# Light programs

Light programs are simple scripts that allow end-users to build custom light sequences that go beyond the fixed car related functions built into the MK4 TLC5940 LPC812 light controller.

Light programs can be triggered when the light controller goes into certain states of operation. For example, a light program can be written to flash a 3rd brake light whenever the brakes are enganged.

Light programs are entered into the corresponding edit field in the light controller *configurator.html*.

A total number of 20 light programs can exist at a certain time.

All light programs comprise of the following structure

    run conditions

    constants, variable and led declerations

    statements (= the actual code)

    end

These constructs are described below in further detail.

> **Important**
>
> Every light program **must** end with an ``end`` statement. A new-line
> must be present after the ``end`` statement.


Here is an example of a light program:

    // ----------------------------------------------------------------------
    // Light up the main beam lights while the light controller is
    // initializing.
    //
    // Normally the main beam would be on only if the parking lights are
    // already on, so just the main beam lighting up is a unique
    // identifiaction.
    // ----------------------------------------------------------------------
    run when initializing

    use all leds
    led main-beam-l = led[2]
    led main-beam-r = led[3]

    loop:
        fade all leds stepsize 0
        all leds = 0%
        main-beam-l, main-beam-r = 100%
        sleep 0
        goto loop

    end

Light programs are line-based, meaning a single statement or decleration must be on the same source code line.

Everything from ``//`` until the end of the line is considered as comment.

The ``run when`` line describes the condition that the light controller must be in for the program to run. In this case the light program runs when the light controller is starting up (i.e. waiting a short time until power up until it reads the center points for steering and throttle channels).

``use all leds`` declares that no other light controller function shall control any of the LEDs while this light program is running. The lines ``led ... = led[y]`` assign human readable names to light outputs 2 and 3.

This ends the decleration section.

The ``loop:`` statement defines a label that can be used to jump to from a ``goto`` instruction.

``fade all leds stepsize 0`` turns slowly fading LEDs in and out off for all LEDs, i.e. all LEDs turn on and off in an instant.

Then all LEDs are switched off, after which led[2] and led[3] are specifically set to fully on (100% brightness).

The light program pauses then for one 20 ms period (``sleep 0``), which causes the LED values we assigned to be actually executed and other light controller functions to run.
Without the sleep statement the light program would run for 50 internal instructions before being forcefully paused, which is unnecessary. After the 20 ms are over the ``goto`` statement is executed and the light program continues from the begin.

The following sections explain all elements of the light program language in detail.


## Comments and line continuation

Everything behind ``//`` or ``;`` until the end of the line is considered a *comment*.

Comments are useful for describing what the light program does. The comments are not stored into the light controller itself, but can be saved in the *configurator.html* through saving the current configuration.

Here is a valid light program showing various forms of comments:

    // This is a test to ensure the comment system works
    //

    // Another comment, with an empty line in front
    run always  // no-signal

        sleep 1     // Sleep for 1 ms. Actually will sleep for about 20ms...
    pos1:
        sleep 2     // Sleep for 2ms // Comment in comment
        goto forward_decleration
        ; Also semicolons can be used for comments
    pos2:               ; This is a comment at a label
        sleep 3
        goto pos1

    forward_decleration:
        sleep 4
    //pos2:
    ;  pos2:
        goto pos2

        end

While light programs are line-based, if the last character on a line is ``\`` the statement is assumed to be continued on the following line. This can be useful to prevent excessively long lines.

The following shows a valid light program, but it is certainly not advisable to write like this:

    run \
       when\
        indicator-left or braking \
        or \        // Comment here, should not matter ...
        indicator-right blink-flag \

    // ^ That linefeed has terminated the run when statement

        sleep 0
    pos1 :
    pos2 \
    :                  // Not very readable, but correct...
        sleep \
            2
            goto \
                pos1
        goto \
    pos2

        end


## Identifiers

Light programs can assign human readable names to constants, variables, LEDs and labels. These are called identifiers.

Identifiers must start with a character ``a..z`` or ``A..Z`` and continue with a number of alphanumeric characters, ``-`` or ``_``. Identifiers are case sensitive.

### Examples of valid identifiers

    testvariable
    var_with_underscore
    name-with-dash
    ThisOneHas1Number

### Examples of invalid identifiers

    3test       // does not start with a..zA..Z
    name&value  // & not allowed in identifiers
    _min        // does not start with a..zA..Z


## Run conditions

*Run conditions* define the state the light controller must be in for a light program to be executed. Each light program defines its own run condition. More than one light program may run at the same time.

There are several types of *run conditions*:

* Events

    Events are single-shot actions that can trigger execution of a light program. At the moment the only event supported by the light controller is "gear changed". Events have the highest priority of all *run conditions*.

* Priority run conditions

    These run conditions take precendence over ordinary run coditions.

* Run conditions

    Ordinary conditions like forward, braking, indicators, etc.

A light program can define multiple run conditions of the same type. For example, a light program can be run when the light controller is either *forward*  or *braking*.

However, a light program can not mix events, priority run conditions and run conditions.

Run conditions must be the first no-comment or empty line in the light program.
The syntax is as follows:

    run always
    run when cond1
    run when cond1 cond2
    run when cond1 or cond2

``run always`` is a special condition that runs the light program at all times.

``run when cond1`` describes a single condition that must be met for the light program to run.

``run when cond1 cond2`` and ``run when cond1 or cond2`` are identical and define that the light program shall be executed when *cond1* **or** *cond2* are met.


### Priority run conditions and events

- no-signal

    The light program runs when the light controller does not receive a valid servo input signal.

- initializing

    The light program runs after startup while the light controller waits before reading center points of steering and throttle channels.

- servo-output-setup-centre, servo-output-setup-left, servo-output-setup-right

    The light program runs when the respective setup function for the steering wheel servo or gearbox servo is triggered. Performing eight CH3-clicks starts servo setup. These run conditions can be used to drive the lights in a unique manner to guide the user through the servo setup.

- reversing-setup-steering, reversing-setup-throttle

    The light program runs when the servo reversing for the steering/throttle channel is engaged. Performing seven CH3-clicks starts steering and throttle reversing. These run conditions can be used to guide the user through the setup process.

- gear-changed

    This event fires whenever the gear is changed. It only applies when the light controller is configured to drive a 2-speed or 3-speed gearbox using a servo connected to the OUT/ISP ouptut. The run condition can be used to perform a short light animation, indicating to the user that the gear change occured.


### Run conditions

- light-switch-position-0 .. light-switch-position-8

    The light program runs when the virtual light switch, which is incremented by one CH3-click and decremented by two CH3-clicks, is in the given postion.

- neutral, forward, reversing, braking

    The light program runs when the throttle is in neutral, the car is driving forward, reversing, or is braking. Neutral, forward and reversing are mutually exclusive. Braking may be active when in parallel with the other states.
    The exact behaviour of these conditions depends on the ESC configuration of the light controller. For example, if the ESC type is configured as Forward/Brake only, then a light program with the condition``run when reversing`` will never execute.

- indicator-left, indicator-right

    The light program runs when the left/right indicator (turn signal) is active. The indicators are engaged by having throttle and steering in neutral for one second, and then moving the steering either left or right.

- hazard

    The light program runs when the hazard lights are active. The hazard lights can be toggled on/off with four CH3-clicks.

- blink-flag

    The light program runs during the bright period of the blink timer used for indicators and hazard lights. By default the blink frequency is 1.5 Hz (320 ms half-period during which the blink-flag is set).

- blink-left, blink-right

    The light program runs during the bright period of the respective left or right indicator light.

- winch-disabled, winch-idle, winch-in, winch-out

    The light program runs during the respective winch state. This applies if the light controller is configured to drive the [LANE Boys RC winch controller](https://github.com/laneboysrc/rc-winch-controller).
    The winch states are mutually exclusive.


## Constants

Good programming practice suggests to never use immediate number values within code, but rather define the values as constants at the begin of the program. This can make maintenance easier, i.e. to change the same delay time used in several places within a light program.

A constant is declared by giving it an identifier and assigning a value:

    const LOOP_COUNT = 10
    const thisIsAConstant_too = 42
    const constant3 = 3

The constants can then be used in the light program:

    // Blink LED 5 three times
    var count
    led light = led[5]
    const LOOP_COUNT = 3
    const BLINK_DELAY = 250
    const BRIGHTNESS = 40

        count = 0

    loop:
        light = BRIGHTNESS
        sleep BLINK_DELAY

        light = 0
        sleep BLINK_DELAY

        count += 1
        skip if count >= LOOP_COUNT
        goto loop

        end

## Declerations

The decleration section defines the LEDs and variables used by the light program and assigns human readable names to them.

Variable and LED declerations can appear in any order in the decleration section.

### Variable declerations

Variables are storage locations that hold numeric values. In total all light programs can utilize up to 100 variables.

Variables have a data type of *signed 16-bit integer*. This means that the range of numbers that can be stored is *-32768* to *32767*.

A variable is created by declaring its identifier:

    var ThisIsAVariable
    var another-one

Variables can also be used to exchange information between different light programs. These are called *global variables*. All programs that want to access a global variable must use the same identifier when declaring the variable.

Light program 1:

    global var i_am_global
    var but_i_am_local
    global var VARIABLE3

Light program 2:

    global var i_am_global
    var VARIABLE3

Light program 3:

    global var VARIABLE3

Light programs 1 and 2 share the global variable ``i_am_global``.
Light program 1 and 3 declare another global variable ``VARIABLE3``. Light program 2 also declares ``VARIABLE3``, but as local variable, so in this example ``VARIABLE3`` of light program 2 is a separate, private storage location from the global ``VARIABLE3`` shared by light programs 1 and 3.


There two global variables predefined for all light programs:

- clicks

    This variable is incremented every time six CH3-clicks are performed. Useful to control different sequences in a light program.

- light-switch-position

    This variable reflects the current position of the virtual light switch. It can be modified by light programs to turn the light switch to a specific position as well.


### LED declerations

LED declerations serve two purpose:

- They define which LEDs are used by the light program, preventing lower priority light programs and car functions to overwrite the LED brightness while the light program is running.

- They give human readable names to LEDs, which also makes it easy to swap LED outputs at a later time.

LEDs are declared as follows:

    use all leds
    led identifier = led[0]
    led slave_led_15 = led[31]
    led yet-another-led = led[1]

``use all leds`` gives the light program control of all LEDs. This is useful for light programs that intend to take over all LEDs during special run conditions such as ``initializing`` or ``no-signal``.

Assigning identifiers to individual LEDs follows the form ``led x = led[y]`` where ``x`` is the identifier and ``y`` is the number of the LED output of the light controller to use. For a single light controller the output number range is ``0..15``. The LEDs on a slave light controller range from ``16..31``.


### Taking control of LEDs

LEDs may be addressed by more than one light program, and may also be assigned any of the standard car light functions (brake light, indicator ...).

A priority scheme has been implemented to clearly define which function has control over an LED:

    Events                  (highest priority)

    Priority run condition

    Run condition

    Normal car functions    (lowest priority)

Light programs that have an event as run condition have the highest priority. Then follow light programs with priority run conditions. After that light programs with ordinary run conditions. If the LED is still available after this the normal car function assigned to it in the *configurator.html* is performed.

Within the same priority group, the first light program specified in the light program source code gets access to the LED.

When a light program is active but one or more LED have been used already by another light program of higher priority, the light program will still continue to run but any setting of LED values and fade times will not be carried out.

It is therefore important for light programs to be implemented with awareness that higher priority light programs may re-assign LED brightness and fade values (see later sections). As such every light program should always set fade and light values and not rely that it has set a certain value earlier, as the values may have been overwritten by another light program executing at higher priority.


## Statements

The actual light program function is described in a sequence of statements, which are described in this section.

### Statement arguments

Most statements support a variety of different arguments:

    var x
    led LED1a = led[8]

    x = 42          // Immedite decimal number
    x = -1          // Immedite negative decimal number
    sleep 0x14      // Immediate hexadecimal number
    sleep x         // Use value of a variable as sleep time in milliseconds
    x = LED1a       // Current value of led[8], range 0..100
    x = random      // A pseudo-random value between -32768 and 32767
    x = clicks      // Pre-defined global variable "clicks"
    x = light-switch-position  // Pre-defined global variable
    x = steering    // Steering channel (range: -100..100), read-only
    x = throttle    // Throttle channel (range: -100..100), read-only
    x = gear        // Current gear, read only,
                    //   only useful if gearbox servo support is enabled


### Assignments

Variables can be assigned a value:

    var x
    var y
    led LED1a = led[8]

    x = 42          // Assign decimal number 42
    x = -1          // Assign decimal number -1 (variables are signed 16-bit)
    x = 0xbeef      // Assign hexadecimal number BEEF
    x = y           // Copy value of variable "y"
    x = LED1a       // Copy value of led[8] (range: 0..100)
    x = random      // Retrieve a random value
    x = clicks      // Copy value of global variable "clicks"
    x = steering    // Copy value of steering channel (range: -100..100)
    x = throttle    // Copy value of throttle channel (range: -100..100)

Assignments to variables can also perform mathematical functions:

    x += 42         // x = x + 42
    x -= 0xcafe     // x = x - 0xcafe
    x *= 0xbabe
    x /= LED1a
    x &= y          // bit-wise AND
    x |= 0x80       // bit-wise OR
    x ^= 15         // bit-wise XOR

> **Division by zero**
>
> If a ``x /= y`` assignment is made where the divisor is 0 then the result
> is set to 32767 (largest possible integer value).


The assigment operations for LEDs is limited: only immediate values or values stored in variables can be assigned. No mathematical operations can be performed. However, multiple LEDs can be assigned in a single statement.

    var x
    led LED1a = led[8]
    led LED1b = led[9]
    led LED1c = led[10]
    led LED1d = led[11]
    led LED2 = led[4]

    LED1a = 100     // Turn the LED fully on
    LED1a = 100%    // Exactly the same as above,
                    //   the % sign can be added for clarity

    LED1a, LED1b, LED1c, LED1d = 25  // Set multiple LEDs at once

    // Set multiple LEDs at once, however because the LED numbers are
    // no longer consecutive this translates into two light program
    // instructions.
    LED1a, LED1b, LED2 = 50%

    // Set LED to the value stored in variable x. If the value of x is
    // negative or zero the LED is turned off. If the value of x is
    // greater or equal to 100 the LED is turned fully on.
    LED1d = x
    LED1c, LED1d = x

The brightness values are specified using values between 0 (LED is off) and 100 (LED is driven at the maximum current of 20 mA). For intermediate values, gamma correction is applied to adjust for the non-linearity of the human eye. The correction is done in a way that 50% is roughly half the perceived brightness of 100%.
The gamma correction factor can be adjusted in the advanced configuration of the light controller.

Beside specifying LEDs individually, the shortcut ``all leds`` allows assigning values to all declared LEDs.

    led LED1a = led[8]
    led LED1b = led[9]
    led LED1c = led[10]
    led LED1d = led[11]
    led LED2 = led[4]

    all leds = 0    // Turns LED1a, LED1b, LED1c, LED1d and LED2 off

If ``use all led`` is declared, then the ``all leds`` shortcut affects all LEDs of the light controller, not just the ones declared individually.

    use all leds
    led LED1a = led[8]
    led LED1b = led[9]

    all leds = 0    // Turns led[0..15] off
    LED1a = 100     // Turns led[8] fully on
    LED1b = 50      // Turns led[9] to half brightness.


### Labels

Labels are identifiers that mark locations in the light program that can be jumped to with the ``goto`` statement.

Labels must appear on their own line. They do not perform any activity, nor do they consume memory. Labels comprise of an identifier followed by a ``:``.

Example:

    run always

        sleep 1
    pos1:
        sleep 2
        goto forward_decleration

    pos2:
        sleep 3
        goto pos1

    forward_decleration:
        sleep 4
        goto pos2

        end


### Goto

The ``goto`` statement redirects program execution to a different part of the light program. The parameter of the ``goto`` statement must be a label identifier that resides in the same light program.

> **Important**
>
> It is not possible to branch to a label in another light program.


### Sleep

The ``sleep`` statment suspends the execution of the light program for the given number of milliseconds. The resolution of timing is 20 milliseconds, which means that ``sleep 1`` causes a suspension for 20 ms rather than 1 ms.

It is only when a light program is suspended that the LED values assigned by the program are becoming into effect. It is therefore good practice to add ``sleep`` statements in loops of light programs.

Since the light contoller firmware is implemented using a *mainloop* and co-operative multi-tasking, light programs are forcefully suspended for one mainloop every 50 statements if no ``sleep`` statement is encountered during execution of the light program.


### Fade

Instead of turning LEDs on in an instant, the light controller supports gradually increasing and decreasing of brightness. This feature was originally designed to simulate incandescent bulbs, but may be useful for other effects.

Light programs are able to control fading of LEDs using the ``fade`` command.

The ``fade`` command has a ``stepsize`` parameter, which determines the maximum brightness change an LED performs within 20 milliseconds.

    var x
    led LED1a = led[8]
    led LED1b = led[9]
    led LED1c = led[10]
    led LED1d = led[11]
    led LED2 = led[4]

    all leds = 0%
    fade LED2 stepsize 0
    fade LED1a, LED1b, LED1c, LED1d stepsize 20
    all leds = 100%

This light program turns LEDs LED1a, LED1b, LED1c, LED1d and LED2 off, then sets that LED2 changes brightness immediately (``stepsize 0``), LED1a..d change at most 20% per 20 milliseconds, and finally turns all declared LEDs to full brightness.
This will turn on LED2 to full brightness immediately (no fading) and LED1a..d will fade to full brightness within 100 ms (``stepsize 20`` means there are 5 steps needed to go from 0 to 100, each step taking 20 ms).


### Conditional statements

Light programs can make use of ``skip if`` statements to change program flow depending on various conditions.

    var x
    global var y
    led l = led[7]
    led l2 = led[8]

    somewhere:
        skip if x == 1      // Skip the next statement, which happens to be
                            // "goto" but could be any statement, if value of
                            // variable x is equal to 1
        goto somewhere

        // Further statements after skip if removed for brevity

        skip if x != 2      // skip if x not equal 2
        skip if x > 3       // skip if x greater than 3
        skip if y < 4       // skip if y less than 4
        skip if x >= 5      // skip if x greater or equal to 5
        skip if x <= 6      // skip if x less than or equal to 6

        skip if x == y      // skip if value of x is same as value of y

        skip if x != l      // skip if value of variable x is not the same
                            // as the value of led[7]

        skip if l >= 5      // skip if led[7] is greater or equal to 5
        skip if l > x       // skip if led[7] is greater than value of x
        skip if l2 < l      // skip if value of led[8] is less than value
                            // of led[7]

Any valid light program statement can follow a ``skip if`` instruction.

    led l = led[7]

        // Turn the LED off if throttle is below 80%, otherwise on
        l = 0
        skip if throttle < 80
        l = 100

However, care has to be taken with assignments to multiple LEDs:

    led l1 = led[7]
    led l2 = led[8]
    led l3 = led[9]

        // Turn the LED off if throttle is below 80%, otherwise on
        l1, l2, l3 = 0
        skip if throttle < 80
        l1, l2, l3 = 100

This will work fine as the LED assignment works on consecutive LEDs, which can be encoded in a single machine operation. However, if another user would modify this light program to use different, non-consecutive LEDs, thing go wrong:

    led l1 = led[0]
    led l2 = led[8]
    led l3 = led[9]

        // Turn the LED off if throttle is below 80%, otherwise on
        l1, l2, l3 = 0
        skip if throttle < 80
        l1, l2, l3 = 100        // This is no longer a single operation!

The light program assembler translates this into the following statements:

    led l1 = led[0]
    led l2 = led[8]
    led l3 = led[9]

        // Turn the LED off if throttle is below 80%, otherwise on
        l1 = 0
        l2, l3 = 0
        skip if throttle < 80
        l1 = 100
        l2, l3 = 100

The behaviour would be incorrect as l2 and l3 will be always on and only l1 will be on when the throttle is greater or equal to 80.
The light program assembler will therefore generate an error message if multiple LEDs are assigned after a ``skip if`` statement.

Note that this also applies to the ``all leds`` shortcut.


The second form of the ``skip if`` statement allows to change program behaviour based on the *car state*.

    skip if is hazard       // skip if single car state condition is true
    sleep 1

    skip if not hazard      // skip if single car state condition is false
    sleep 1

    // skip if any of the specified car states is true
    skip if any hazard indicator-left indicator-right
    sleep 1

    // skip if all specified car states is true
    skip if all hazard indicator-left indicator-right
    sleep 1

    // skip if all of the specified car states is true (i.e. all are false)
    skip if none hazard indicator-left indicator-right
    sleep 1

The following car states can be tested using ``skip if`` statements:


- light-switch-position-0 .. light-switch-position-8

    The virtual light switch position, which is incremented by one CH3-click and decremented by two CH3-clicks.

- neutral, forward, reversing, braking

    The throttle is in neutral, the car is driving forward, reversing, or is braking.

- indicator-left, indicator-right

    The left/right indicator (turn signal) is engaged.

- hazard

    The hazard lights are engaged.

- blink-flag

    The bright period of the blink timer used for indicators and hazard lights is active.

- blink-left, blink-right

    The left/right indicator or hazard light is engaged and the blink timer is in the bright period.

- winch-disabled, winch-idle, winch-in, winch-out

    The state of the winch.

- servo-output-setup-centre, servo-output-setup-left, servo-output-setup-right

    The setup function for the steering wheel servo or gearbox servo is triggered.

- reversing-setup-steering, reversing-setup-throttle

    The servo reversing for the steering/throttle channel is engaged.


## The ``end`` statement

Every light program **must** end with an ``end`` statement. A new-line must be added after the ``end`` statement, otherwise an error will be reported when the light program is processed by *configurator.html*.
