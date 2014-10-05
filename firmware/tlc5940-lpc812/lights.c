/******************************************************************************


    Light scenarios to consider

    - Always-on of certain LEDs
    - Dynamic discover of light_position_switch maximum value
        * This is done by the firmware generator, not at run-time
    - Combined tail / brake lights
    - Combined tail / brake / indicator lights (XR311, Sawback)
    - Hazard and indicators
    - Consider single and multi-color LEDs
    - Consider half brightness is not half LED current
        - Implement gamma correction at the output step
        - Fixed gamma table in FLASH, generated by firmware egenerator
    - Simulation of incadescent bulbs
        From Wikipedia: For a 100-watt, 120-volt general-service lamp, the
        current stabilizes in about 0.10 seconds, and the lamp reaches 90% of
        its full brightness after about 0.13 seconds.
    - Simulation of weak ground connection
    - Support weird, unforeseen combinations, like combined reverse/indicators
      on the Lancia Fulvia
    * We need to handle WS2812 as well as PL9823 (swapped rgb order!)
    * Consider HSL fading?!

    * Setup
        * No signal (1 entry)
            * At run-time it depends on the receiver, but we can still detect
              broken wires (timeout 500ms)
        * Initializing (startup mode neutral; 1 entry)
        * Setup of steering, throttle reverse (2 entries)
        * Setup of the output servo centre, left, right (3 entries)
        * That would be 1568 bytes total, quite a bit!
            * We rather allow up to 10 LEDs being specified, others are off
            * This will take only 280 bytes (everything RGB)

    * Events
        * Can trigger a sequence
        * Gear change
        *   Different sequence depending on gear value
        *   Different sequence depending on state of roof lights?
        * Any other?


    Flags for normal car lights:
    - always on
    - light switch position (max 0..8), 0 is off (default)
        - Can be used to implement parking, main beam, high beam, etc
    - tail light (= any light switch position other than 0)
    - brakeing
    - reversing
    - indicator left
    - indicator left


    Incadescent:
        Configurable time. Default: 140ms. Applies to full scale.
        As assume linear rise/decay (perceived brigthness, gamma corrected).
        Given that we change every systtick, this means that maximum
        value (before gamma correction) we change is 256 / 120ms / 20ms == 37
        Note that if the maximum brightness of a lamp is not 100%, this value
        should be adjusted (e.g. if max is 50%, use double the time constant,
        or half the max step size.) This should be automatically done in the
        firmware generator (max_steps_per_systick).


    Weak ground connection:
        For each led be able to specify a flag indicating which car light
        function is influencing it. For example, a weak ground connecton
        on a combinled trai / brake LED that should be influenced by the
        left indicator, would set the left indicator flag only.
        There would also be a configurable brightness reduction value in %



    Light programs:
        * Bogdan's idea regarding flame simulation, depending on throttle
        * Programs reside at the end of flash space
        * Do we need to limit the number of programs?
            * Most likely yes, otherwise we need to scan the whole flash
              every systick to find all programs
        * Mini programming language
            * GOTO to implement loops
            * SET led value (monochrome, translates to command below)
            * SET start_led stop_led value
            * SET(0..95) red green blue (takes up a lot of opcodes!)
            * FADE led time (translates to command below)
            * FADE start_led stop_led time
            * WAIT time
            * IF condition (skips next instruction if false)
                * VARIABLE == integer, VAR2
                * VARIABLE > integer, VAR2
                * VARIABLE < integer, VAR2
                * VARIABLE != integer, VAR2
                * car state: implement as AND and OR mask?
                * ANY car state
                * ALL car state
                * NONE car state
            * IF NOT condition (skips next instruction if true)
            * VARIABLE = integer
            * VARIABLE += integer (signed, so -= can work with same opcode!)
            * Reading values of lights?

            * Different sequence depending on gear value?
            * Different sequence depending on state of roof lights?
            * Random value
            * "Next sequence"
            * 0x00 and 0xff should not be used (empty flash, 0 initialized)
        * Every opcode is 4 bytes
            * This means that 1 byte command + 3 bytes RGB is possible
            * End-of-program marker to find different programs in the flash
        * The lights used in a program are automatically removed from normal
          car light processing
        * Issue: how to return to the normal program if a light program has
          an IF .. GOTO loop that waits for a certain condition?
            * Return if false?
            * Detect if a GOTO lands on a IF?
            * Return after a number of instructions?
        * Programs are active because of an event, or because of a match state
        * Program triggering events
            * Gearbox change event
            * There can only be one event active
            * New events stop currently running events
            * Event programs have priority over other programs regarding light use
        * Programs states
            * Always
            * Winch active
            * Any of the car states
                * light switch position[9]
                * tail light (shortcut to light switch position > 0)
                * neutral (not available yet)
                * forward
                * reversing
                * braking
                * indicator left (static flag)
                * indicator left (static flag)
                * hazard (static flag)
                * blink flag
                * blink indicator left
                * blink indicator right
                * gear 1
                * gear 2
            * Multiple programs can be running in parallel
                * If multiple programs run then the first program using a
                  particular light wins, the other can not use that light
        Program metadata
            * FLASH: State or event the program runs
            * FLASH: LEDs used (16 + 32 + 16 + 32 = 96 bits = 12 bytes)
            * FLASH: RAM used
            * RAM: Shadow values for all used LEDs
            * RAM: fade time, start time, led, start value, end value
            * RAM: program counter
                * Gets reset every time a program is not running
            * RAM: variables


    Test programs:
        Night rider with LEDs 0..3:
            0:  SET LED0 LED3 0
            1:  FADE    LED0    120
            2:  FADE    LED1    120
            3:  FADE    LED2    120
            4:  FADE    LED3    120
            5:  SET     LED0    255
            6:  WAIT    120
            7:  SET     LED0    0
            8:  SET     LED1    255
            9:  WAIT    120
            10: SET     LED1    0
            11: SET     LED2    255
            12: WAIT    120
            13: SET     LED2    0
            14: SET     LED3    255
            15: WAIT    120
            16: SET     LED3    0
            17: SET     LED2    255
            18: WAIT    120
            19: SET     LED2    0
            20: SET     LED1    255
            21: WAIT    120
            22: SET     LED1    0
            23: GOTO    5


******************************************************************************/
#include <stdint.h>
#include <stdbool.h>
#include <LPC8xx.h>

#include <globals.h>
#include <uart0.h>


#define SLAVE_MAGIC_BYTE ((uint8_t)0x87)

#define GPIO_GSCLK LPC_GPIO_PORT->W0[1]
#define GPIO_BLANK LPC_GPIO_PORT->W0[6]
#define GPIO_XLAT LPC_GPIO_PORT->W0[2]
#define GPIO_SCK LPC_GPIO_PORT->W0[3]
#define GPIO_SIN LPC_GPIO_PORT->W0[7]


typedef enum {
    ALWAYS_ON,
    LIGHT_SWITCH_POSITION,
    LIGHT_SWITCH_POSITION_0 = LIGHT_SWITCH_POSITION + 0,
    LIGHT_SWITCH_POSITION_1 = LIGHT_SWITCH_POSITION + 1,
    LIGHT_SWITCH_POSITION_2 = LIGHT_SWITCH_POSITION + 2,
    LIGHT_SWITCH_POSITION_3 = LIGHT_SWITCH_POSITION + 3,
    LIGHT_SWITCH_POSITION_4 = LIGHT_SWITCH_POSITION + 4,
    LIGHT_SWITCH_POSITION_5 = LIGHT_SWITCH_POSITION + 5,
    LIGHT_SWITCH_POSITION_6 = LIGHT_SWITCH_POSITION + 6,
    LIGHT_SWITCH_POSITION_7 = LIGHT_SWITCH_POSITION + 7,
    LIGHT_SWITCH_POSITION_8 = LIGHT_SWITCH_POSITION + 8,
    TAIL_LIGHT,
    BRAKE_LIGHT,
    REVERSING_LIGHT,
    INDICATOR_LEFT,
    INDICATOR_RIGHT
} CAR_LIGHT_FUNCTION_T;


static uint8_t light_switch_position;
static LED_T tlc5940_light_data[16];


// ****************************************************************************
static void send_light_data_to_tlc5940(void)
{
    volatile int i;

    // Wait for MSTIDLE
    while (!(LPC_SPI0->STAT & (1 << 8)));

    for (i = 15; i >= 0; i--) {
        // Wait for TXRDY
        while (!(LPC_SPI0->STAT & (1 << 1)));

        LPC_SPI0->TXDAT = gamma_table.gamma_table[tlc5940_light_data[i]] >> 2;
    }

    // Force END OF TRANSFER
    LPC_SPI0->STAT = (1 << 7);
}


// ****************************************************************************
// SPI configuration:
//     Configuration: CPOL = 0, CPHA = 0,
//     We can send 6 bit frame lengths, so no need to pack light data!
//     TXRDY indicates when we can put the next data into txbuf
//     Use SSEL function to de-assert XLAT while sending new data
// ****************************************************************************
void init_lights(void)
{
    GPIO_BLANK = 1;
    GPIO_GSCLK = 0;
    GPIO_XLAT = 0;

    LPC_GPIO_PORT->DIR0 |=
        (1 << 1) | (1 << 2) | (1 << 3) | (1 << 6) | (1 << 7);

    // Use 2 MHz SPI clock. 16 bytes take about 50 us to transmit.
    LPC_SPI0->DIV = (__SYSTEM_CLOCK / 2000000) - 1;

    LPC_SPI0->CFG = (1 << 0) |          // Enable SPI0
                    (1 << 2) |          // Master mode
                    (0 << 3) |          // LSB First mode disabled
                    (0 << 4) |          // CPHA = 0
                    (0 << 5) |          // CPOL = 0
                    (0 << 8);           // SPOL = 0

    LPC_SPI0->TXCTRL = (1 << 21) |      // set EOF
                       (1 << 22) |      // RXIGNORE, otherwise SPI hangs until
                                        //   we read the data register
                       ((6 - 1) << 24); // 6 bit frames

    // We use the SSEL function for XLAT: low during the transmission, high
    // during the idle periood.
    LPC_SWM->PINASSIGN3 = 0x03ffffff;   // PIO0_3 is SCK
    LPC_SWM->PINASSIGN4 = 0xff02ff07;   // PIO0_2 is XLAT (SSEL) PIO0_3 is SIN (MOSI)

    send_light_data_to_tlc5940();

    GPIO_BLANK = 0;
    GPIO_GSCLK = 1;
}


// ****************************************************************************
void next_light_sequence(void)
{
	;
}


// ****************************************************************************
void light_switch_up(void)
{
    if (light_switch_position < (config.light_switch_positions - 1)) {
        ++light_switch_position;
    }
}


// ****************************************************************************
void light_switch_down(void)
{
    if (light_switch_position > 0) {
        --light_switch_position;
    }
}


// ****************************************************************************
void toggle_light_switch(void)
{
    if (light_switch_position < (config.light_switch_positions - 1)) {
        light_switch_position = config.light_switch_positions - 1;
    }
    else {
        light_switch_position = 0;
    }
}


// ****************************************************************************
static const LED_T *get_light_value(const CAR_LIGHT_T *light, 
    CAR_LIGHT_FUNCTION_T function)
{
    switch (function) {
        case ALWAYS_ON:
            return &light->always_on;

        case LIGHT_SWITCH_POSITION_0:
        case LIGHT_SWITCH_POSITION_1:
        case LIGHT_SWITCH_POSITION_2:
        case LIGHT_SWITCH_POSITION_3:
        case LIGHT_SWITCH_POSITION_4:
        case LIGHT_SWITCH_POSITION_5:
        case LIGHT_SWITCH_POSITION_6:
        case LIGHT_SWITCH_POSITION_7:
        case LIGHT_SWITCH_POSITION_8:
            return &light->light_switch_position[
                function - LIGHT_SWITCH_POSITION];

        case TAIL_LIGHT:
            return &light->tail_light;

        case BRAKE_LIGHT:
            return &light->brake_light;

        case REVERSING_LIGHT:
            return &light->reversing_light;

        case INDICATOR_LEFT:
            return &light->indicator_left;

        case INDICATOR_RIGHT:
            return &light->indicator_right;

        default:
            return (uint8_t []){0};
    }
}


// ****************************************************************************
static bool is_value_zero(const CAR_LIGHT_T *light, 
    CAR_LIGHT_FUNCTION_T function)
{
    const LED_T * value = get_light_value(light, function);

    return *value == 0 ? true : false;
}


// ****************************************************************************
static void set_light(LED_T *led, const LED_T *value)
{
    *led = *value;
}


// ****************************************************************************
static void mix_light(LED_T *led, const LED_T *value)
{
    *led = MAX(*led, *value);
}


// ****************************************************************************
static LED_T calculate_step_value(LED_T current, LED_T new, uint8_t max_change)
{
    LED_T adjusted_max_change;

    if (new > current) {
        adjusted_max_change = MIN(max_change, 0xff - current);
        return MIN(new, current + adjusted_max_change);
    }
    else {
        adjusted_max_change = MIN(max_change, current);
        return MAX(new, current - adjusted_max_change);
    }
}


// ****************************************************************************
static void limit_stepsize(const CAR_LIGHT_T *light, LED_T *led, 
    const LED_T *value)
{
    LED_T adjusted_value = *value;
    
    // If max_change_per_systick is not set allow full swing
    if (light->features.max_change_per_systick > 0) {
        adjusted_value = calculate_step_value(
            *led, *value, light->features.max_change_per_systick);

    }

    set_light(led, &adjusted_value);
}


// ****************************************************************************
static void set_car_light(LED_T *led, const CAR_LIGHT_T *light,
    CAR_LIGHT_FUNCTION_T function)
{
    set_light(led, get_light_value(light, function));
}


// ****************************************************************************
static void mix_car_light(LED_T *led, const CAR_LIGHT_T *light,
    CAR_LIGHT_FUNCTION_T function)
{
    mix_light(led, get_light_value(light, function));
}


// ****************************************************************************
static void combined_tail_brake(LED_T *led, const CAR_LIGHT_T *light)
{
    if (light_switch_position > 0) {
        mix_car_light(led, light, TAIL_LIGHT);
    }

    if (global_flags.braking) {
        mix_car_light(led, light, BRAKE_LIGHT);
    }
}


// ****************************************************************************
static void combined_tail_brake_indicators(LED_T *led, const CAR_LIGHT_T *light)
{
    if (global_flags.blink_hazard ||
            (global_flags.blink_indicator_left &&
                !is_value_zero(light, INDICATOR_LEFT)) ||
            (global_flags.blink_indicator_right &&
                !is_value_zero(light, INDICATOR_RIGHT))) {
        //                         BLINKFLAG
        //                      on          off
        // --------------------------------------
        // Tail + Brake off     blink       off
        // Tail                 tail        off
        // Brake                brake       off
        // Tail + Brake         brake       tail

        if (global_flags.blink_flag) {
            // Bright blink period: Brake value has highest priority, followed
            // by tail and finally the indicator value

            if (global_flags.braking) {
                mix_car_light(led, light, BRAKE_LIGHT);
            }
            else if (light_switch_position > 0) {
                mix_car_light(led, light, TAIL_LIGHT);
            }
            else {
                if (global_flags.blink_indicator_left
                    || global_flags.blink_hazard) {
                    mix_car_light(led, light, INDICATOR_LEFT);
                }
                if (global_flags.blink_indicator_right
                    || global_flags.blink_hazard) {
                    mix_car_light(led, light, INDICATOR_RIGHT);
                }
            }
        }
        else {
            // Dark blink period: light is off unless both tail and brake are
            // active

            if (light_switch_position > 0 && global_flags.braking) {
                mix_car_light(led, light, TAIL_LIGHT);
            }
        }
    }
    else {
        // No indicator active: process like normal tail/brake lights
        combined_tail_brake(led, light);
    }
}


// ****************************************************************************
static bool is_light_affected(const LIGHT_FEATURE_T *w)
{
    if (w->light_switch_position_0 && light_switch_position == 0) {
        return true;
    }

    if (w->light_switch_position_1 && light_switch_position == 1) {
        return true;
    }

    if (w->light_switch_position_2 && light_switch_position == 2) {
        return true;
    }

    if (w->light_switch_position_3 && light_switch_position == 3) {
        return true;
    }

    if (w->light_switch_position_4 && light_switch_position == 4) {
        return true;
    }

    if (w->light_switch_position_5 && light_switch_position == 5) {
        return true;
    }

    if (w->light_switch_position_6 && light_switch_position == 6) {
        return true;
    }

    if (w->light_switch_position_7 && light_switch_position == 7) {
        return true;
    }

    if (w->light_switch_position_8 && light_switch_position == 8) {
        return true;
    }

    if (w->tail_light && light_switch_position > 0) {
        return true;
    }

    if (w->brake_light && global_flags.braking) {
        return true;
    }

    if (w->reversing_light && global_flags.reversing) {
        return true;
    }

    if (w->indicator_left && global_flags.blink_flag &&
            (global_flags.blink_indicator_left || global_flags.blink_hazard)) {
        return true;
    }

    if (w->indicator_right && global_flags.blink_flag &&
            (global_flags.blink_indicator_right || global_flags.blink_hazard)) {
        return true;
    }

    return false;
}


// ****************************************************************************
static void simulate_weak_ground(LED_T *led, const CAR_LIGHT_T *light)
{

    if (light->features.reduction_percent == 0) {
        return;
    }

    if (is_light_affected(&light->features)) {
        *led = (uint16_t)(*led) *
            (100 - light->features.reduction_percent) / 100;
    }
}


// ****************************************************************************
static void process_light(const CAR_LIGHT_T *light, LED_T *led)
{
    LED_T result = 0;

    set_car_light(&result, light, ALWAYS_ON);

    mix_car_light(&result, light, LIGHT_SWITCH_POSITION + light_switch_position);

    if (global_flags.reversing) {
        mix_car_light(&result, light, REVERSING_LIGHT);
    }
    if (!is_value_zero(light, TAIL_LIGHT) &&
        !is_value_zero(light, BRAKE_LIGHT) &&
        (   !is_value_zero(light, INDICATOR_LEFT) ||
            !is_value_zero(light, INDICATOR_RIGHT))) {
        // Special case for combined tail / brake / indicators
        combined_tail_brake_indicators(&result, light);
    }
    else {
        combined_tail_brake(&result, light);

        if (global_flags.blink_flag) {
            if (global_flags.blink_hazard ||
                global_flags.blink_indicator_left) {
                mix_car_light(&result, light, INDICATOR_LEFT);
            }
            if (global_flags.blink_hazard ||
                global_flags.blink_indicator_right) {
                mix_car_light(&result, light, INDICATOR_RIGHT);
            }
        }
    }

    simulate_weak_ground(&result, light);
    limit_stepsize(light, &result, led);
    *led = result;
}


// ****************************************************************************
static void process_setup_lights(const SETUP_ENTRY_T *light_array)
{
    int i;
    volatile uint32_t dummy;
    
    for (i = 0; i < 10; i++) {
        dummy += light_array[i].value;        
    }
}


// ****************************************************************************
static void process_car_lights(void)
{
    int i;

    if (global_flags.initializing) {
        process_setup_lights(setup_lights.initializing);
    }
    if (global_flags.no_signal) {
        process_setup_lights(setup_lights.no_signal);
    }
    if (global_flags.servo_output_setup == SERVO_OUTPUT_SETUP_LEFT) {
        process_setup_lights(setup_lights.servo_setup_left);
    }
    if (global_flags.servo_output_setup == SERVO_OUTPUT_SETUP_CENTRE) {
        process_setup_lights(setup_lights.servo_setup_centre);
    }
    if (global_flags.servo_output_setup == SERVO_OUTPUT_SETUP_RIGHT) {
        process_setup_lights(setup_lights.servo_setup_right);
    }
    if (global_flags.reversing_setup != REVERSING_SETUP_OFF) {
        if (global_flags.reversing_setup == REVERSING_SETUP_STEERING) {
            process_setup_lights(setup_lights.reverse_setup_steering);
        }
        if (global_flags.reversing_setup == REVERSING_SETUP_THROTTLE) {
            process_setup_lights(setup_lights.reverse_setup_throttle);
        }
    }


    // Handle LEDs connected to the TLC5940 locally
    for (i = 0; i < local_leds.led_count ; i++) {
        process_light(&local_leds.car_lights[i], &tlc5940_light_data[i]);
    }
    send_light_data_to_tlc5940();

    if (config.flags.slave_output) {
        LED_T led = 0;

        uart0_send_char(SLAVE_MAGIC_BYTE);

        // Handle LEDs connected to a slave light controller
        for (i = 0; i < slave_leds.led_count ; i++) {
            process_light(&slave_leds.car_lights[i], &led);
            uart0_send_char(gamma_table.gamma_table[led] >> 2);
        }
    }
}


// ****************************************************************************
void process_lights(void)
{
    static uint8_t old_light_switch_position = 0xff;

    if (light_switch_position != old_light_switch_position) {
        old_light_switch_position = light_switch_position;
        uart0_send_cstring("light_switch_position ");
        uart0_send_uint32(light_switch_position);
        uart0_send_linefeed();
    }

    if (global_flags.systick) {
        process_car_lights();
    }
}
