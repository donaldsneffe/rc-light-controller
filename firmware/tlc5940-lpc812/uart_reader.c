/******************************************************************************

    This function returns after having successfully received a complete
    protocol frame via the UART.

    The frame size is either 4 or 5 bytes. The traditional preprocessor sent
    4 byte frames, the new one with the HK310 expansion protocol sends 5 byte
    frames.

    This software automatically determines the frame size upon startup. It
    checks the number of bytes in the first few frames and only then
    outputs values.


    The preprocessor protocol is as follows:

    The first byte is always 0x87, which indicates that it is a start byte. No
    other byte can have this value.

    The second byte is a signed char of the steering channel, from -100 to 0
    (Neutral) to +100, corresponding to the percentage of steering left/right.

    The third byte is a signed char of the throttle channel, from -100 to 0
    (Neutral) to +100.

    The fourth byte holds CH3 in the lowest bit (0 or 1), and bit 4 indicates
    whether the preprocessor is initializing. Note that the other bits must
    be zero as this is required by the light controller (waste of bits, poor
    implementation...)

    The (optional) 5th byte is the normalized 6-bit value of CH3 as used in the
    HK310 expansion protocol. This module ignores that value.
    TODO: describe this better, and define the range including both SYNC values

 *****************************************************************************/
#include <stdint.h>
#include <LPC8xx.h>

#include <globals.h>
#include <uart0.h>

// FIXME: don't update CH3 if a push button is used


#define SLAVE_MAGIC_BYTE 0x87
#define CONSECUTIVE_BYTE_COUNTS 3

typedef enum {
    STATE_WAIT_FOR_MAGIC_BYTE = 0,
    STATE_STEERING,
    STATE_THROTTLE,
    STATE_CH3,
    STATE_CH3_EXTENDED,
    STATE_INVALID
} STATE_T;


// ****************************************************************************
void init_uart_reader(void)
{
    int i;

    if (config.mode == MASTER_WITH_SERVO_READER) {
        // Turn the UART output on unless a servo output is requested
        if (!config.flags.steering_wheel_servo_output &&
            !config.flags.gearbox_servo_output) {
            // U0_TXT_O=PIO0_12
            LPC_SWM->PINASSIGN0 = 0xffffff0c;
        }
    }
    else {
        // U0_TXT_O=PIO0_4, U0_RXD_I=PIO0_0
        LPC_SWM->PINASSIGN0 = 0xffff0004;
    }

    if (config.mode != MASTER_WITH_UART_READER) {
        return;
    }

    for (i = 0; i < 3; i++) {
        channel[i].normalized = 0;
        channel[i].absolute = 0;
        channel[i].reversed = false;
    }

    global_flags.startup_mode_neutral = 1;
}


// ****************************************************************************
static void normalize_channel(CHANNEL_T *c, uint8_t data)
{
    if (data > 127) {
        c->normalized = -(256 - data);
    }
    else {
        c->normalized = data;
    }

    if (c->normalized < 0) {
        c->absolute = -c->normalized;
    }
    else {
        c->absolute = c->normalized;
    }
}


// ****************************************************************************
void read_preprocessor(void)
{
    static STATE_T state = STATE_WAIT_FOR_MAGIC_BYTE;
    static uint8_t channel_data[3];
    static int8_t byte_count = -1;
    static int8_t init_count = CONSECUTIVE_BYTE_COUNTS;

    uint8_t uart_byte;

    if (config.mode != MASTER_WITH_UART_READER) {
        return;
    }

    global_flags.new_channel_data = false;

    while (uart0_read_is_byte_pending()) {
        uart_byte = uart0_read_byte();

        if (uart_byte == SLAVE_MAGIC_BYTE) {
            // The first /init_count/ consecutive frames must have the same number
            // of bytes
            if (init_count) {
                if (state == STATE_CH3_EXTENDED || state == STATE_INVALID) {
                    if (byte_count == state) {
                        --init_count;
                    }
                    else {
                        byte_count = state;
                        init_count = CONSECUTIVE_BYTE_COUNTS;
                    }
                }
            }
            state = STATE_STEERING;
            return;
        }

        switch (state) {
            case STATE_WAIT_FOR_MAGIC_BYTE:
                // Nothing to do; SLAVE_MAGIC_BYTE is checked globally
                break;

            case STATE_STEERING:
                channel_data[0] = uart_byte;
                state = STATE_THROTTLE;
                break;

            case STATE_THROTTLE:
                channel_data[1] = uart_byte;
                state = STATE_CH3;
                break;

            case STATE_CH3:
                channel_data[2] = uart_byte;
                if (init_count || byte_count > 4) {
                    state = STATE_CH3_EXTENDED;
                }
                else {
                    normalize_channel(&channel[ST], channel_data[0]);
                    normalize_channel(&channel[TH], channel_data[1]);

                    global_flags.startup_mode_neutral =
                        (channel_data[2] & 0x10) ? true : false;

                    normalize_channel(&channel[CH3],
                        (channel_data[2] & 0x01) ? 100 : -100);

                    global_flags.new_channel_data = true;
                    state = 0;
                }
                break;

            case STATE_CH3_EXTENDED:
                if (init_count) {
                    state = STATE_INVALID;
                }
                else {
                    normalize_channel(&channel[ST], channel_data[0]);
                    normalize_channel(&channel[TH], channel_data[1]);

                    global_flags.startup_mode_neutral =
                        (channel_data[2] & 0x10) ? true : false;

                    normalize_channel(&channel[CH3],
                        (channel_data[2] & 0x01) ? 100 : -100);

                    global_flags.new_channel_data = true;
                    state = STATE_WAIT_FOR_MAGIC_BYTE;
                }
                break;

            case STATE_INVALID:
                // Dummy state used for counting
                break;

            default:
                break;
        }
    }
}

