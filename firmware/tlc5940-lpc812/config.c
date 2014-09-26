#include <stdint.h>
#include <globals.h>

const LIGHT_CONTROLLER_CONFIG_T config = {
    ROM_MAGIC,                  // magic
    0x01,                       // type

    (800 / __SYSTICK_IN_MS),    // auto_brake_counter_value_forward_min
    (2500 / __SYSTICK_IN_MS),   // auto_brake_counter_value_forward_min
    (800 / __SYSTICK_IN_MS),    // auto_brake_counter_value_reverse_min
    (2500 / __SYSTICK_IN_MS),   // auto_brake_counter_value_reverse_min
    (800 / __SYSTICK_IN_MS),    // auto_reverse_counter_value_min
    (2000 / __SYSTICK_IN_MS),   // auto_reverse_counter_value_max
    (1000 / __SYSTICK_IN_MS),   // brake_disarm_counter_value

    8,                          // centre_threshold_low
    10,                         // centre_threshold
    12,                         // centre_threshold_high

};