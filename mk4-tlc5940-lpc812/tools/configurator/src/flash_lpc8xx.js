
class flash_lpc8xx {
    constructor(uart) {
        this.uart = uart;

        this.progressCallback = null;
        this.messageCallback = null;
        this.cancelButtonEnableFunction = null;
        this.wait = true;
        this.busy = false;
        this.cancel_ = false;

        // Code Read Protection (CRP) address and patterns
        this.CRP_ADDRESS = 0x000002fc;

        // Prevents sampling of the ISP entry pin
        this.NO_ISP = 0x4E697370;

        // Access to chip via the SWD pins is disabled; allow partial flash update
        this.CRP1 = 0x12345678;

        // Access to chip via the SWD pins is disabled; most flash commands are disabled
        this.CRP2 = 0x87654321;

        // Access to chip via the SWD pins is disabled; prevents sampling of the ISP
        // entry pin
        this.CRP3 = 0x43218765;

        // RAM start address we use for programming and the Go command. We use
        // 0x10000300 because everything below may be locked by CRP.
        this.RAM_BASE_ADDRESS = 0x10000000;
        this.RAM_ADDRESS = this.RAM_BASE_ADDRESS + 0x300;

        this.FLASH_BASE_ADDRESS = 0x00000000;
        this.PAGE_SIZE = 64;
        this.SECTOR_SIZE = 1024;

        this.allow_code_protection = false;
    }

    message(msg) {
        if (this.messageCallback) {
            this.messageCallback(msg);
        }
    }

    async send_command(command){
        // Send a command to the ISP and check that we receive and COMMAND_SUCCESS (0)
        // response.
        //
        // Note that this function assumes that ECHO is turned off.

        await this.uart.write(command + '\r\n');
        let response = await this.uart.readline();
        if (response != '0\r\n') {
            throw 'ERROR: Command "' + command + '" failed. Return code: ' + response;
        }
    }

    append_signature(bin) {
        // Calculate the signature that the ISP uses to detect "valid code"

        let signature = 0;
        for (let i = 0 ; i < 7; i += 1) {
            let vector = i * 4;
            signature = signature + (
                (bin[vector + 3] << 24) +
                (bin[vector + 2] << 16) +
                (bin[vector + 1] << 8) +
                (bin[vector]));
        }
        signature = (signature ^ 0xffffffff) + 1;   // Two's complement

        let vector8 = 28;
        bin[vector8 + 3] = (signature >> 24) & 0xff;
        bin[vector8 + 2] = (signature >> 16) & 0xff;
        bin[vector8 + 1] = (signature >> 8) & 0xff;
        bin[vector8] = signature & 0xff;
    }

    async open_isp(port) {
        await this.uart.open(port, 115200, 8, 'n', 1);
        await this.uart.setTimeout(0.3);

        if (this.wait) {
            this.message('Waiting for LPC81x to enter ISP mode...');
        }

        while (!this.cancel_) {
            await this.uart.write('?');

            let response = await this.uart.readline();
            if (response == 'Synchronized\r\n') {

                await this.uart.write('Synchronized\r\n');
                await this.uart.readline();        // Discard echo

                response = await this.uart.readline();
                if (response != 'OK\r\n') {
                    throw 'ERROR: Expected "OK" after sending  "Synchronized", but received "' + response + '"';
                }

                // Send crystal frequency in kHz (always 12 MHz for the LPC81x)
                await this.uart.write('12000\r\n');
                await this.uart.readline();        // Discard echo

                response = await this.uart.readline();
                if (response != 'OK\r\n') {
                    throw 'ERROR: Expected "OK" after sending crystal frequency, but received "' + response + '"';
                }

                await this.uart.write('A 0\r\n');  // Turn ECHO off
                await this.uart.readline();        // Discard (last) echo

                response = await this.uart.readline();
                if (response != '0\r\n') {
                    throw 'ERROR: Expected "0" after turning ECHO off, but received "' + response + '"';
                }
                await this.uart.setTimeout(5);
                return;
            }

            else if (response == '?') {
                // We may already be in ISP mode, with ECHO being on.
                // We terminate with CR/LF, which should respond with "1\r\n" because
                // '?' is an invalid command.
                // We have to skip the ECHOed CR/LF though!
                await this.uart.write('\r\n');
                await this.uart.readline();        // Discard echo

                response = await this.uart.readline();
                if (response != '1\r\n') {
                    if (!this.wait) {
                        throw 'ERROR: LPC81x not in ISP mode.';
                    }
                }
                else {
                    await this.uart.write('A 0\r\n');      // Turn ECHO off
                    await this.uart.readline();            // Discard (last) echo

                    response = await this.uart.readline();
                    if (response != '0\r\n') {
                        throw 'ERROR: Expected "0" after turning ECHO off, but received "' + response + '"';
                    }
                    await this.uart.setTimeout(5);
                    return;
                }
            }

            else {
                // We may already be in ISP mode, with ECHO being off.
                // We send a CR/LF, which should respond with "1\r\n" because
                // '?' is an invalid command.
                await this.uart.write('\r\n');

                response = await this.uart.readline();
                if (response == '1\r\n') {
                    await this.uart.setTimeout(5);
                    return;
                }
                if (!this.wait) {
                    throw 'ERROR: LPC81x not in ISP mode.';
                }
            }
        }
    }

    async program(bin) {
        // Write the given binary image file into the flash memory.

        // The image is checked whether it contains any of the code protection
        // values, and flashing is aborted (unless instructed with a flag)
        // so that we don't "brick" the ISP functionality.

        // Also the checksum of the vectors that the ISP uses to detect valid
        // flash is generated and added to the image before flashing.

        let used_sectors = (bin.length / this.SECTOR_SIZE);


        // Abort if the Code Read Protection in the image contains one of the
        // special patterns. We don't want to lock us out of the chip...
        if (!this.allow_code_protection) {
            let pattern = ((bin[this.CRP_ADDRESS + 3] << 24) + (bin[this.CRP_ADDRESS + 2] << 16) + (bin[this.CRP_ADDRESS + 1] << 8) + bin[this.CRP_ADDRESS]);

            if (pattern == this.NO_ISP) {
                throw 'ERROR: NO_ISP code read protection detected in image file';
            }

            if (pattern == this.CRP1) {
                throw 'ERROR: CRP1 code read protection detected in image file';
            }

            if (pattern == this.CRP2) {
                throw 'ERROR: CRP2 code read protection detected in image file';
            }

            if (pattern == this.CRP3) {
                throw 'ERROR: CRP3 code read protection detected in image file';
            }
        }


        // Calculate the signature that the ISP uses to detect "valid code"
        this.append_signature(bin);

        // Unlock the chip with the magic number
        await this.send_command('U 23130');


        // Program the image
        for (let index = 0; index < used_sectors; index += 1) {
            if (this.progressCallback) {
                this.progressCallback(index / used_sectors);
            }

            let sector = index;

            // Erase the sector
            await this.send_command('P ' + sector + ' ' + sector);
            await this.send_command('E ' + sector + ' ' + sector);

            let address = sector * this.SECTOR_SIZE;
            let last_address = address + this.SECTOR_SIZE - 1;

            let data = bin.slice(address, last_address+1);

            await this.send_command('W ' + this.RAM_ADDRESS + ' ' + data.length);
            await this.uart.write(data);
            await this.send_command('P ' + sector + ' ' + sector);
            await this.send_command('C ' + address + ' ' + this.RAM_ADDRESS + ' ' + this.SECTOR_SIZE);
        }

        if (this.progressCallback) {
            this.progressCallback(1.0);
        }
    }

    async read_part_id() {
        await this.send_command('J');
        let id = await this.uart.readline();
        return id.trim();
    }

    async get_flash_size() {
        // Obtain the size of the Flash memory from the LPC81x.
        // If we are unable to identify the part we assume a default of 4 KBytes.

        const known_parts = {
            0x00008100: 4 * 1024,       // LPC810M021FN8
            0x00008110: 8 * 1024,       // LPC811M001JDH16
            0x00008120: 16 * 1024,      // PC812M101JDH16
            0x00008121: 16 * 1024,      // LPC812M101JD20
            0x00008122: 16 * 1024       // LPC812M101JDH20, LPC812M101JTB16
        };

        let part_id = await this.read_part_id();

        if (known_parts.hasOwnProperty(part_id)) {
            return known_parts[part_id];
        }

        this.message('Unknown part identification ' + part_id + '. Using 4 KB as flash size.');
        return 4 * 1024;
    }

    async read() {
        let flash_size = await this.get_flash_size();
        this.message('Reading ' + flash_size + ' bytes ...');

        await this.send_command('R ' + this.FLASH_BASE_ADDRESS + ' ' + flash_size);
        let image_data = await this.uart.read(flash_size);
        if (image_data.length !== flash_size) {
            throw 'Failed to read the whole Flash memory';
        }

        let binaryData = [];
        for (let i=0; i<image_data.length; i+=1) {
            binaryData.push(image_data.charCodeAt(i));
        }
        return binaryData;
    }

    async reset_mcu() {
        /*
        Reset the MCU to start the application.
        We do that by downloading a small binary into RAM. This binary corresponds
        to the following C code:

            SCB->AIRCR = 0x05FA0004;

        This code resets the ARM CPU by setting SYSRESETREQ. We load this
        program into RAM and run it with the "Go" command.
        */
        const reset_program = [
            0x01, 0x4a, 0x02, 0x4b, 0x1a, 0x60, 0x70, 0x47,
            0x04, 0x00, 0xfa, 0x05, 0x0c, 0xed, 0x00, 0xe0];

        await this.send_command('W ' + this.RAM_ADDRESS + ' ' + reset_program.length);
        await this.uart.write(reset_program);

        // Unlock the Go command
        await this.send_command('U 23130');

        // Run the program from RAM. Note that this command does not respond with
        // COMMAND_SUCCESS as it directly executes.
        await this.uart.write('G ' + this.RAM_ADDRESS + ' T\r\n');
    }

    async flash(port, bin) {
        let success = false;

        if (this.busy) {
            this.message('Flashing already in progress');
            return success;
        }
        this.busy = true;
        this.cancel_ = false;

        try {
            await this.open_isp(port);

            if (!this.cancel_) {
                // Point of no-return, disable cancel button
                if (this.cancelButtonEnableFunction) {
                    this.cancelButtonEnableFunction(false);
                }

                this.message('Programming ...');
                await this.program(bin);
                this.message('Starting the program...');
                await this.reset_mcu();
                this.message('Done.');
            }
            success = true;
        }
        catch (e) {
            this.message('Error: ' + e);
        }
        finally {
            await this.uart.close();
            this.busy = false;
        }

        return success;
    }

    async read_flash(port) {
        let bin = [];

        if (this.busy) {
            this.message('Reading already in progress');
            return bin;
        }
        this.busy = true;

        try {
            await this.open_isp(port);

            if (!this.cancel_) {
                // Point of no-return, disable cancel button
                if (this.cancelButtonEnableFunction) {
                    this.cancelButtonEnableFunction(false);
                }

                this.message('Reading ...');
                bin = await this.read();
                this.message('Done.');
            }
        }
        catch (e) {
            this.message('Error: ' + e);
        }
        finally {
            await this.uart.close();
            this.busy = false;
        }

        return bin;
    }

    cancel() {
        this.cancel_ = true;
    }

    set onMessageCallback(fn) {
        this.messageCallback = fn;
    }

    set onProgressCallback(fn) {
        this.progressCallback = fn;
    }

    set setCancelButtonEnabled(fn) {
        this.cancelButtonEnableFunction = fn;
    }
}
