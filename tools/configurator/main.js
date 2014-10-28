"use strict";

var app = (function () {
    var el = {};  // Cache of document.getElementById

    var firmware;
    var config;
    var local_leds;
    var slave_leds;

    var LIGHT_SWITCH_POSITIONS = 9;
    var MAX_LIGHT_PROGRAMS = 25;
    var MAX_LIGHT_PROGRAM_VARIABLES = 100;

    var CONFIG_VERSION = 1;


    var SECTION_CONFIG = "Configuration";
    var SECTION_GAMMA = "Gamma table";
    var SECTION_LIGHT_PROGRAMS = "Light programs";
    var SECTION_LOCAL_LEDS = "Local LEDs";
    var SECTION_SLAVE_LEDS = "Slave LEDs";

    var SECTIONS = {
        0x01: SECTION_CONFIG,
        0x02: SECTION_GAMMA,
        0x10: SECTION_LOCAL_LEDS,
        0x20: SECTION_SLAVE_LEDS,
        0x30: SECTION_LIGHT_PROGRAMS,

        SECTION_CONFIG: 0x01,
        SECTION_GAMMA: 0x02,
        SECTION_LOCAL_LEDS: 0x10,
        SECTION_SLAVE_LEDS: 0x20,
        SECTION_LIGHT_PROGRAMS: 0x30
    };


    var MASTER_WITH_SERVO_READER = "Master, servo inputs";
    var MASTER_WITH_UART_READER = "Master, pre-processor input";
    var SLAVE = "Slave";

    var MODE = {
        0: MASTER_WITH_SERVO_READER,
        1: MASTER_WITH_UART_READER,
        2: SLAVE,

        MASTER_WITH_SERVO_READER: 0,
        MASTER_WITH_UART_READER: 1,
        SLAVE: 2
    };


    var ESC_FORWARD_BRAKE_REVERSE = "Forward/Brake/Reverse";
    var ESC_FORWARD_REVERSE = "Forward/Reverse";
    var ESC_FORWARD_BRAKE = "Forward/Brake";

    var ESC_MODE = {
        0: ESC_FORWARD_BRAKE_REVERSE,
        1: ESC_FORWARD_REVERSE,
        2: ESC_FORWARD_BRAKE,

        ESC_FORWARD_BRAKE_REVERSE: 0,
        ESC_FORWARD_REVERSE: 1,
        ESC_FORWARD_BRAKE: 2
    };


    var BAUDRATES = {
        0: 38400,
        1: 115200,

        38400: 0,
        115200: 1
    };


    // *************************************************************************
    var parse_leds = function (section) {
        var data = firmware.data;
        var offset = firmware.offset[section];
        var result = {};

        var led_count = data[offset];
        result['led_count'] = led_count;

        var car_lights_offset = get_uint32(data, offset + 4);

        function parse_led (data, offset) {
            var result = {}

            result['max_change_per_systick'] = data[offset];
            result['reduction_percent'] = data[offset + 1];

            var flags = get_uint16(data, offset + 2);

            function get_flag(bit_mask) {
                return Boolean(flags & bit_mask);
            }

            result['weak_light_switch_position0'] = get_flag(1 << 0);
            result['weak_light_switch_position1'] = get_flag(1 << 1);
            result['weak_light_switch_position2'] = get_flag(1 << 2);
            result['weak_light_switch_position3'] = get_flag(1 << 3);
            result['weak_light_switch_position4'] = get_flag(1 << 4);
            result['weak_light_switch_position5'] = get_flag(1 << 5);
            result['weak_light_switch_position6'] = get_flag(1 << 6);
            result['weak_light_switch_position7'] = get_flag(1 << 7);
            result['weak_light_switch_position8'] = get_flag(1 << 8);
            result['weak_tail_light'] = get_flag(1 << 9);
            result['weak_tail_light'] = get_flag(1 << 10);
            result['weak_reversing_light'] = get_flag(1 << 11);
            result['weak_indicator_left'] = get_flag(1 << 12);
            result['weak_indicator_right'] = get_flag(1 << 13);

            result['always_on'] = data[offset + 4];
            result['light_switch_position0'] = data[offset + 5];
            result['light_switch_position1'] = data[offset + 6];
            result['light_switch_position2'] = data[offset + 7];
            result['light_switch_position3'] = data[offset + 8];
            result['light_switch_position4'] = data[offset + 9];
            result['light_switch_position5'] = data[offset + 10];
            result['light_switch_position6'] = data[offset + 11];
            result['light_switch_position7'] = data[offset + 12];
            result['light_switch_position8'] = data[offset + 13];
            result['tail_light'] = data[offset + 14];
            result['brake_light'] = data[offset + 15];
            result['reversing_light'] = data[offset + 16];
            result['indicator_left'] = data[offset + 17];
            result['indicator_right'] = data[offset + 18];

            return result;
        }

        for (var i = 0; i < led_count; i++) {
            result[i] = parse_led(data, car_lights_offset + (i * 20));
        }

        return result;
    };


    // *************************************************************************
    var parse_configuration = function () {
        var data = firmware.data;
        var offset = firmware.offset[SECTION_CONFIG];

        var config = {};

        config['mode'] = data[offset];
        config['esc_mode'] = data[offset+1];

        var flags = get_uint32(data, offset + 4);

        function get_flag(bit_mask) {
            return Boolean(flags & bit_mask);
        }

        config['slave_ouput'] = get_flag(1 << 0);
        config['preprocessor_output'] = get_flag(1 << 1);
        config['winch_output'] = get_flag(1 << 2);
        config['steering_wheel_servo_output'] = get_flag(1 << 3);
        config['gearbox_servo_output'] = get_flag(1 << 4);
        config['ch3_is_local_switch'] = get_flag(1 << 5);
        config['ch3_is_momentary'] = get_flag(1 << 6);
        config['auto_brake_lights_forward_enabled'] = get_flag(1 << 7);
        config['auto_brake_lights_reverse_enabled'] = get_flag(1 << 8);
        config['brake_disarm_timeout_enabled'] = get_flag(1 << 9);

        config['auto_brake_counter_value_forward_min'] = get_uint16(data, offset + 8);
        config['auto_brake_counter_value_forward_max'] = get_uint16(data, offset + 10);
        config['auto_brake_counter_value_reverse_min'] = get_uint16(data, offset + 12);
        config['auto_brake_counter_value_reverse_max'] = get_uint16(data, offset + 14);
        config['auto_reverse_counter_value_min'] = get_uint16(data, offset + 16);
        config['auto_reverse_counter_value_max'] = get_uint16(data, offset + 18);
        config['brake_disarm_counter_value'] = get_uint16(data, offset + 20);
        config['blink_counter_value'] = get_uint16(data, offset + 22);
        config['indicator_idle_time_value'] = get_uint16(data, offset + 24);
        config['indicator_off_timeout_value'] = get_uint16(data, offset + 26);

        config['centre_threshold_low'] = get_uint16(data, offset + 28);
        config['centre_threshold'] = get_uint16(data, offset + 30);
        config['centre_threshold_high'] = get_uint16(data, offset + 32);
        config['blink_threshold'] = get_uint16(data, offset + 34);
        config['light_switch_positions'] = get_uint16(data, offset + 36);
        config['initial_endpoint_delta'] = get_uint16(data, offset + 38);
        config['ch3_multi_click_timeout'] = get_uint16(data, offset + 40);
        config['winch_command_repeat_time'] = get_uint16(data, offset + 42);

        config['baudrate'] = get_uint32(data, offset + 44);
        config['no_signal_timeout'] = get_uint16(data, offset + 48);

        return config;
    };


    // *************************************************************************
    var get_uint16 = function (data, offset) {
        return (data[offset + 1] << 8) + data[offset];
    };


    // *************************************************************************
    var get_uint32 = function (data, offset) {
        return (data[offset + 3] << 24) + (data[offset + 2] << 16) +
            (data[offset + 1] << 8) + data[offset];
    };


    // *************************************************************************
    var uint8_array_to_uint32 = function (uint8_array) {
        var uint32_array = [];
        var i = 0;

        while ((i + 4) <=  uint8_array.length) {
            uint32_array.push(get_uint32(uint8_array, i));
            i += 4;
        }
        return uint32_array;
    }


    // *************************************************************************
    var disassemble_light_programs = function () {
        var data = firmware.data;
        var offset = firmware.offset[SECTION_LIGHT_PROGRAMS];
        var first_program_offset = offset + 4 + (4 * MAX_LIGHT_PROGRAMS);

        var number_of_programs = get_uint32(data, offset);

        var instructions =
            uint8_array_to_uint32(data.slice(first_program_offset));

        return disassembler.disassemble(instructions);
    };


    // *************************************************************************
    var find_magic_markers = function (image_data) {
        // LBrc (LANE Boys RC) in little endian
        var ROM_MAGIC = [0x4c, 0x42, 0x72, 0x63];
        var ROM_MAGIC_LENGTH = 4;

        var result = {};

        for (var i = 0; i < image_data.length; i++) {
            if (image_data.slice(i, i + ROM_MAGIC_LENGTH).join() == ROM_MAGIC.join()) {

                var section_id = (image_data[i + 5] << 8) + image_data[i + 4];
                var version = (image_data[i + 7] << 8) + image_data[i + 6];

                if (typeof SECTIONS[section_id] === "undefined") {
                    console.log("Warning: unknown section " + i);
                    continue;
                }

                if (version != 1) {
                    throw new Error("Unknown configuration version " + version);
                }

                var section = SECTIONS[section_id];
                result[section] = i + 8;
            }
        }

        return result;
    };


    // *************************************************************************
    var load_firmware = function (intel_hex_data) {
        var ih = intel_hex;

        var image_data = ih.parse(intel_hex_data);
        var offset_list = find_magic_markers(image_data.data);

        return {
            data: image_data.data,
            offset: offset_list,
        }
    };


    // *************************************************************************
    var load_intelhex_file_from_disk = function () {
        if (this.files.length < 1) {
            return;
        }

        var reader = new FileReader();
        reader.onload = function (e) {
            load_and_parse_firmware(e.target.result);
        };
        reader.readAsText(this.files[0]);
    }


    // *************************************************************************
    var load_and_parse_firmware = function (intel_hex_data) {
        var code = "";

        firmware = undefined;
        config = undefined;
        local_leds = undefined
        slave_leds = undefined;
        el["light_programs"].innerHTML = code;

        try {
            firmware = load_firmware(intel_hex_data);
            config = parse_configuration();
            local_leds = parse_leds(SECTION_LOCAL_LEDS);
            slave_leds = parse_leds(SECTION_SLAVE_LEDS);
            code = disassemble_light_programs();

            update_ui();
        }
        finally {
            el["light_programs"].innerHTML = code;
        }
    };


    // *************************************************************************
    var update_ui = function () {
        el["mode"].selectedIndex = config["mode"];
        update_mode();

        el["esc"][config['esc_mode']].checked = true;

        el["single_output_out"][0].checked = true;
        el["dual_output_out"][0].checked = true;
        el["dual_output_th"][0].checked = true;
        if (config['slave_ouput']) {
            el["single_output_out"][1].checked = true;
            el["dual_output_tx"][1].checked = true;
        }
        if (config['preprocessor_output']) {
            el["single_output_out"][2].checked = true;
            el["dual_output_tx"][2].checked = true;
        }
        if (config['steering_wheel_servo_output']) {
            el["single_output_out"][3].checked = true;
            el["dual_output_out"][1].checked = true;
        }
        if (config['gearbox_servo_output']) {
            el["single_output_out"][4].checked = true;
            el["dual_output_out"][2].checked = true;
        }
        if (config['winch_output']) {
            el["single_output_out"][5].checked = true;
            el["dual_output_tx"][3].checked = true;
        }

        el["ch3"][0].checked = true;
        if (config['ch3_is_local_switch']) {
            el["ch3"][2].checked = true;
        }
        else if (config['ch3_is_momentary']) {
            el["ch3"][1].checked = true;
        }

        el["baudrate"].selectedIndex = BAUDRATES[config['baudrate']];
    };


    // *************************************************************************
    var update_mode = function () {
        var new_mode = parseInt(
            el["mode"].options[el["mode"].selectedIndex].value, 10);

        switch (new_mode) {
            case MODE['MASTER_WITH_SERVO_READER']:
                el["config_light_programs"].style.display = "block";
                el["config_leds"].style.display = "block";
                el["config_basic"].style.display = "block";
                el["config_advanced"].style.display = "block";
                el["single_output"].style.display = "block";
                el["dual_output"].style.display = "none";
                config["mode"] = new_mode;
                break;

            case MODE['MASTER_WITH_UART_READER']:
                el["config_light_programs"].style.display = "block";
                el["config_leds"].style.display = "block";
                el["config_basic"].style.display = "block";
                el["config_advanced"].style.display = "block";
                el["single_output"].style.display = "none";
                el["dual_output"].style.display = "block";
                config["mode"] = new_mode;
                break;

            case MODE['SLAVE']:
                el["config_light_programs"].style.display = "none";
                el["config_leds"].style.display = "none";
                el["config_basic"].style.display = "none";
                el["config_advanced"].style.display = "none";
                config["mode"] = new_mode;
                break;
        }

        var show_slave_leds = false;
        if (config["mode"] == MODE["MASTER_WITH_SERVO_READER"]) {
            show_slave_leds = Boolean(el["single_output_out"][1].checked);
        }
        else if (config["mode"] == MODE["MASTER_WITH_UART_READER"]) {
            show_slave_leds = Boolean(el["dual_output_th"][1].checked);
        }
        el["leds_slave"].style.display = show_slave_leds ? "block" : "none";

    };


    // *************************************************************************
    var init = function () {
        el["mode"] = document.getElementById("mode");

        el["intelhex"] = document.getElementById("intelhex");

        el["config_leds"] = document.getElementById("config_leds");
        el["leds_master"] = document.getElementById("leds_master");
        el["leds_slave"] = document.getElementById("leds_slave");

        el["config_basic"] = document.getElementById("config_basic");
        el["baudrate"] = document.getElementById("baudrate");
        el["esc"] = document.getElementsByName("esc");
        el["ch3"] = document.getElementsByName("ch3");

        el["single_output"] = document.getElementById("single_output");
        el["dual_output"] = document.getElementById("dual_output");
        el["single_output_out"] = document.getElementsByName("single_output_out");
        el["dual_output_out"] = document.getElementsByName("dual_output_out");
        el["dual_output_th"] = document.getElementsByName("dual_output_th");

        el["config_light_programs"] = document.getElementById("config_light_programs");
        el["light_programs"] = document.getElementById("light_programs");

        el["config_advanced"] = document.getElementById("config_advanced");


        el["mode"].addEventListener("change", update_mode, false);
        el["single_output"].addEventListener("change", update_mode, false);
        el["dual_output"].addEventListener("change", update_mode, false);
        el["intelhex"].addEventListener("change", load_intelhex_file_from_disk, false);


        load_and_parse_firmware(default_firmware_image);
    };


    // *************************************************************************
    return {
        load: load_intelhex_file_from_disk,
        init: init
    };
})();


// *****************************************************************************
document.addEventListener("DOMContentLoaded", function () {
    ui.init();
    app.init();
}, false);