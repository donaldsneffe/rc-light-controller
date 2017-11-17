EESchema Schematic File Version 2
LIBS:SAM_D11
LIBS:power
LIBS:device
LIBS:switches
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:texas
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:diode
LIBS:ESD_Protection
LIBS:mk5-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L TLC5940PWP U4
U 1 1 59C45A36
P 9250 3650
F 0 "U4" H 8750 4525 50  0000 L CNN
F 1 "TLC5940PWP" H 9300 4525 50  0000 L CNN
F 2 "Housings_SSOP:HTSSOP-28_4.4x9.7mm_Pitch0.65mm_ThermalPad" H 9275 2675 50  0001 L CNN
F 3 "" H 8850 4350 50  0001 C CNN
	1    9250 3650
	1    0    0    -1  
$EndComp
$Comp
L USB_OTG J2
U 1 1 59C45BE8
P 1650 5250
F 0 "J2" H 1450 5700 50  0000 L CNN
F 1 "USB" H 1450 5600 50  0000 L CNN
F 2 "USB:Mirco_USB_Type_B_eBay_AliExpress" H 1800 5200 50  0001 C CNN
F 3 "" H 1800 5200 50  0001 C CNN
	1    1650 5250
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR01
U 1 1 59C45D35
P 5700 4800
F 0 "#PWR01" H 5700 4550 50  0001 C CNN
F 1 "GND" H 5700 4650 50  0000 C CNN
F 2 "" H 5700 4800 50  0001 C CNN
F 3 "" H 5700 4800 50  0001 C CNN
	1    5700 4800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 59C45D7F
P 9250 5000
F 0 "#PWR02" H 9250 4750 50  0001 C CNN
F 1 "GND" H 9250 4850 50  0000 C CNN
F 2 "" H 9250 5000 50  0001 C CNN
F 3 "" H 9250 5000 50  0001 C CNN
	1    9250 5000
	1    0    0    -1  
$EndComp
$Comp
L +3V3 #PWR03
U 1 1 59C45E41
P 9250 2350
F 0 "#PWR03" H 9250 2200 50  0001 C CNN
F 1 "+3V3" H 9250 2490 50  0000 C CNN
F 2 "" H 9250 2350 50  0001 C CNN
F 3 "" H 9250 2350 50  0001 C CNN
	1    9250 2350
	1    0    0    -1  
$EndComp
$Comp
L +3V3 #PWR04
U 1 1 59C45E7A
P 5700 2100
F 0 "#PWR04" H 5700 1950 50  0001 C CNN
F 1 "+3V3" H 5700 2240 50  0000 C CNN
F 2 "" H 5700 2100 50  0001 C CNN
F 3 "" H 5700 2100 50  0001 C CNN
	1    5700 2100
	1    0    0    -1  
$EndComp
$Comp
L SW_Push SW1
U 1 1 59C45F57
P 1250 3650
F 0 "SW1" H 1300 3750 50  0000 L CNN
F 1 "BTN" H 1250 3590 50  0000 C CNN
F 2 "Buttons_Switches_SMD:SW_SPST_SKQG" H 1250 3850 50  0001 C CNN
F 3 "" H 1250 3850 50  0001 C CNN
	1    1250 3650
	0    1    1    0   
$EndComp
$Comp
L TEST TP1
U 1 1 59C46169
P 6000 5950
F 0 "TP1" V 6000 6150 50  0000 L BNN
F 1 "SWCLK" V 6050 6150 50  0000 L CNN
F 2 "Measurement_Points:Measurement_Point_Round-SMD-Pad_Small" H 6000 5950 50  0001 C CNN
F 3 "" H 6000 5950 50  0001 C CNN
	1    6000 5950
	0    1    1    0   
$EndComp
$Comp
L TEST TP2
U 1 1 59C46225
P 6000 6200
F 0 "TP2" V 6000 6400 50  0000 L BNN
F 1 "SWDIO" V 6050 6400 50  0000 L CNN
F 2 "Measurement_Points:Measurement_Point_Round-SMD-Pad_Small" H 6000 6200 50  0001 C CNN
F 3 "" H 6000 6200 50  0001 C CNN
	1    6000 6200
	0    1    1    0   
$EndComp
$Comp
L TEST TP3
U 1 1 59C4652D
P 6000 6450
F 0 "TP3" V 6000 6650 50  0000 L BNN
F 1 "RESET" V 6050 6650 50  0000 L CNN
F 2 "Measurement_Points:Measurement_Point_Round-SMD-Pad_Small" H 6000 6450 50  0001 C CNN
F 3 "" H 6000 6450 50  0001 C CNN
	1    6000 6450
	0    1    1    0   
$EndComp
Text Label 6850 3800 2    60   ~ 0
DP
Text Label 6850 3650 2    60   ~ 0
DM
$Comp
L GND #PWR05
U 1 1 59C46A64
P 8550 1550
F 0 "#PWR05" H 8550 1300 50  0001 C CNN
F 1 "GND" H 8550 1400 50  0000 C CNN
F 2 "" H 8550 1550 50  0001 C CNN
F 3 "" H 8550 1550 50  0001 C CNN
	1    8550 1550
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 59C46F6E
P 7750 3300
F 0 "R1" V 7830 3300 50  0000 C CNN
F 1 "2K" V 7750 3300 50  0000 C CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 7680 3300 50  0001 C CNN
F 3 "" H 7750 3300 50  0001 C CNN
	1    7750 3300
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR06
U 1 1 59C4705C
P 7750 3500
F 0 "#PWR06" H 7750 3250 50  0001 C CNN
F 1 "GND" H 7650 3500 50  0000 C CNN
F 2 "" H 7750 3500 50  0001 C CNN
F 3 "" H 7750 3500 50  0001 C CNN
	1    7750 3500
	1    0    0    -1  
$EndComp
$Comp
L C C4
U 1 1 59C47154
P 9500 2450
F 0 "C4" H 9525 2550 50  0000 L CNN
F 1 "100n" H 9525 2350 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 9538 2300 50  0001 C CNN
F 3 "" H 9500 2450 50  0001 C CNN
	1    9500 2450
	0    1    1    0   
$EndComp
$Comp
L C C3
U 1 1 59C471E5
P 5950 2200
F 0 "C3" H 5975 2300 50  0000 L CNN
F 1 "100n" H 5975 2100 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 5988 2050 50  0001 C CNN
F 3 "" H 5950 2200 50  0001 C CNN
	1    5950 2200
	0    1    1    0   
$EndComp
$Comp
L GND #PWR07
U 1 1 59C472D9
P 6150 2250
F 0 "#PWR07" H 6150 2000 50  0001 C CNN
F 1 "GND" H 6150 2100 50  0000 C CNN
F 2 "" H 6150 2250 50  0001 C CNN
F 3 "" H 6150 2250 50  0001 C CNN
	1    6150 2250
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR08
U 1 1 59C47427
P 9700 2500
F 0 "#PWR08" H 9700 2250 50  0001 C CNN
F 1 "GND" H 9700 2350 50  0000 C CNN
F 2 "" H 9700 2500 50  0001 C CNN
F 3 "" H 9700 2500 50  0001 C CNN
	1    9700 2500
	1    0    0    -1  
$EndComp
$Comp
L MCP1703A-3302_SOT23 U2
U 1 1 59C474C3
P 3650 6700
F 0 "U2" H 3800 6450 50  0000 C CNN
F 1 "MCP1702-3302_SOT23" H 3100 6850 50  0000 L CNN
F 2 "TO_SOT_Packages_SMD:SOT-23" H 3650 6900 50  0001 C CNN
F 3 "" H 3650 6650 50  0001 C CNN
	1    3650 6700
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR09
U 1 1 59C476EE
P 3650 7200
F 0 "#PWR09" H 3650 6950 50  0001 C CNN
F 1 "GND" H 3650 7050 50  0000 C CNN
F 2 "" H 3650 7200 50  0001 C CNN
F 3 "" H 3650 7200 50  0001 C CNN
	1    3650 7200
	1    0    0    -1  
$EndComp
$Comp
L +3V3 #PWR010
U 1 1 59C477CD
P 4150 6600
F 0 "#PWR010" H 4150 6450 50  0001 C CNN
F 1 "+3V3" H 4150 6740 50  0000 C CNN
F 2 "" H 4150 6600 50  0001 C CNN
F 3 "" H 4150 6600 50  0001 C CNN
	1    4150 6600
	1    0    0    -1  
$EndComp
$Comp
L C C2
U 1 1 59C478AC
P 4150 6950
F 0 "C2" H 4175 7050 50  0000 L CNN
F 1 "1u/16V" H 4175 6850 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 4188 6800 50  0001 C CNN
F 3 "" H 4150 6950 50  0001 C CNN
	1    4150 6950
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 59C4792E
P 3100 6950
F 0 "C1" H 3125 7050 50  0000 L CNN
F 1 "1u/16V" H 3125 6850 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 3138 6800 50  0001 C CNN
F 3 "" H 3100 6950 50  0001 C CNN
	1    3100 6950
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR011
U 1 1 59C47A90
P 4150 7200
F 0 "#PWR011" H 4150 6950 50  0001 C CNN
F 1 "GND" H 4150 7050 50  0000 C CNN
F 2 "" H 4150 7200 50  0001 C CNN
F 3 "" H 4150 7200 50  0001 C CNN
	1    4150 7200
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR012
U 1 1 59C47B21
P 3100 7200
F 0 "#PWR012" H 3100 6950 50  0001 C CNN
F 1 "GND" H 3100 7050 50  0000 C CNN
F 2 "" H 3100 7200 50  0001 C CNN
F 3 "" H 3100 7200 50  0001 C CNN
	1    3100 7200
	1    0    0    -1  
$EndComp
$Comp
L D_Schottky D2
U 1 1 59C47D22
P 2450 6700
F 0 "D2" H 2450 6800 50  0000 C CNN
F 1 "BAT760" H 2650 6650 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-323_HandSoldering" H 2450 6700 50  0001 C CNN
F 3 "" H 2450 6700 50  0001 C CNN
	1    2450 6700
	-1   0    0    1   
$EndComp
$Comp
L D_Schottky D1
U 1 1 59C47DAA
P 2450 6450
F 0 "D1" H 2450 6550 50  0000 C CNN
F 1 "BAT760" H 2650 6400 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-323_HandSoldering" H 2450 6450 50  0001 C CNN
F 3 "" H 2450 6450 50  0001 C CNN
	1    2450 6450
	-1   0    0    1   
$EndComp
Wire Wire Line
	5700 4700 5700 4800
Wire Wire Line
	5700 2100 5700 2300
Wire Wire Line
	9250 2350 9250 2650
Wire Wire Line
	4350 3050 4800 3050
Wire Wire Line
	8150 3250 8550 3250
Wire Wire Line
	1250 3150 1250 3450
Wire Wire Line
	4800 3650 4350 3650
Wire Wire Line
	8150 3550 8550 3550
Wire Wire Line
	4800 3350 4350 3350
Wire Wire Line
	8150 3450 8550 3450
Wire Wire Line
	6550 3650 6850 3650
Wire Wire Line
	6550 3800 6850 3800
Wire Wire Line
	8550 1450 8550 1550
Wire Wire Line
	8550 900  8550 1050
Wire Wire Line
	8450 2450 9350 2450
Wire Wire Line
	8450 2450 8450 3150
Wire Wire Line
	8450 2950 8550 2950
Connection ~ 9250 2450
Wire Wire Line
	8450 3150 8550 3150
Connection ~ 8450 2950
Wire Wire Line
	7750 3050 8550 3050
Wire Wire Line
	7750 3450 7750 3500
Wire Wire Line
	5800 2200 5700 2200
Connection ~ 5700 2200
Wire Wire Line
	9650 2450 9700 2450
Wire Wire Line
	9700 2450 9700 2500
Wire Wire Line
	3650 7000 3650 7200
Wire Wire Line
	2600 6700 3350 6700
Wire Wire Line
	3100 6700 3100 6800
Wire Wire Line
	3950 6700 4150 6700
Wire Wire Line
	4150 6600 4150 6800
Connection ~ 4150 6700
Wire Wire Line
	4150 7100 4150 7200
Wire Wire Line
	3100 7100 3100 7200
Connection ~ 3100 6700
Wire Wire Line
	2600 6450 2700 6450
Wire Wire Line
	2700 6250 2700 6950
Connection ~ 2700 6700
Wire Wire Line
	2100 4900 2100 6450
Wire Wire Line
	2100 6450 2300 6450
Wire Wire Line
	1700 6700 2300 6700
$Comp
L Conn_01x01 J3
U 1 1 59C4821D
P 8550 700
F 0 "J3" H 8550 800 50  0000 C CNN
F 1 "OUT15" H 8550 600 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 8550 700 50  0001 C CNN
F 3 "" H 8550 700 50  0001 C CNN
	1    8550 700 
	0    -1   -1   0   
$EndComp
$Comp
L USBLC6-2SC6 U1
U 1 1 59C48B32
P 2900 5450
F 0 "U1" H 2650 5800 50  0000 C CNN
F 1 "USBLC6-2SC6" H 2900 5100 50  0000 C CNN
F 2 "TO_SOT_Packages_SMD:SOT-23-6" H 3550 5800 50  0001 C CNN
F 3 "" H 2650 5800 50  0001 C CNN
	1    2900 5450
	1    0    0    1   
$EndComp
Wire Wire Line
	1950 5250 2400 5250
Wire Wire Line
	1950 5350 2200 5350
Wire Wire Line
	2200 5350 2200 5650
Wire Wire Line
	2200 5650 2400 5650
$Comp
L GND #PWR013
U 1 1 59C49331
P 1650 5950
F 0 "#PWR013" H 1650 5700 50  0001 C CNN
F 1 "GND" H 1650 5800 50  0000 C CNN
F 2 "" H 1650 5950 50  0001 C CNN
F 3 "" H 1650 5950 50  0001 C CNN
	1    1650 5950
	1    0    0    -1  
$EndComp
Wire Wire Line
	1650 5650 1650 5950
Wire Wire Line
	1550 5650 1550 5750
Wire Wire Line
	1550 5750 2300 5750
Connection ~ 1650 5750
Wire Wire Line
	2300 5750 2300 5450
Wire Wire Line
	2300 5450 2400 5450
Connection ~ 2100 5050
Wire Wire Line
	1950 5050 3550 5050
Wire Wire Line
	3550 5050 3550 5450
Wire Wire Line
	3550 5450 3400 5450
Wire Wire Line
	3400 5250 3750 5250
Wire Wire Line
	3400 5650 3750 5650
NoConn ~ 1950 5450
Text Label 3750 5250 2    60   ~ 0
DP
Text Label 3750 5650 2    60   ~ 0
DM
$Comp
L PWR_FLAG #FLG014
U 1 1 59C4A3FC
P 2100 4900
F 0 "#FLG014" H 2100 4975 50  0001 C CNN
F 1 "PWR_FLAG" H 2100 5050 50  0000 C CNN
F 2 "" H 2100 4900 50  0001 C CNN
F 3 "" H 2100 4900 50  0001 C CNN
	1    2100 4900
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG015
U 1 1 59C4A5F6
P 2000 2100
F 0 "#FLG015" H 2000 2175 50  0001 C CNN
F 1 "PWR_FLAG" H 2000 2250 50  0000 C CNN
F 2 "" H 2000 2100 50  0001 C CNN
F 3 "" H 2000 2100 50  0001 C CNN
	1    2000 2100
	1    0    0    -1  
$EndComp
NoConn ~ 8550 3850
NoConn ~ 8550 4450
$Comp
L Conn_01x01 J7
U 1 1 59C4AFD0
P 10550 2950
F 0 "J7" H 10550 3050 50  0000 C CNN
F 1 "Conn_01x01" H 10550 2850 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 2950 50  0001 C CNN
F 3 "" H 10550 2950 50  0001 C CNN
	1    10550 2950
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J8
U 1 1 59C4B114
P 10550 3050
F 0 "J8" H 10550 3150 50  0000 C CNN
F 1 "Conn_01x01" H 10550 2950 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 3050 50  0001 C CNN
F 3 "" H 10550 3050 50  0001 C CNN
	1    10550 3050
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J9
U 1 1 59C4B188
P 10550 3150
F 0 "J9" H 10550 3250 50  0000 C CNN
F 1 "Conn_01x01" H 10550 3050 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 3150 50  0001 C CNN
F 3 "" H 10550 3150 50  0001 C CNN
	1    10550 3150
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J10
U 1 1 59C4B238
P 10550 3250
F 0 "J10" H 10550 3350 50  0000 C CNN
F 1 "Conn_01x01" H 10550 3150 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 3250 50  0001 C CNN
F 3 "" H 10550 3250 50  0001 C CNN
	1    10550 3250
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J11
U 1 1 59C4B296
P 10550 3350
F 0 "J11" H 10550 3450 50  0000 C CNN
F 1 "Conn_01x01" H 10550 3250 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 3350 50  0001 C CNN
F 3 "" H 10550 3350 50  0001 C CNN
	1    10550 3350
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J12
U 1 1 59C4B2F7
P 10550 3450
F 0 "J12" H 10550 3550 50  0000 C CNN
F 1 "Conn_01x01" H 10550 3350 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 3450 50  0001 C CNN
F 3 "" H 10550 3450 50  0001 C CNN
	1    10550 3450
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J13
U 1 1 59C4B35F
P 10550 3550
F 0 "J13" H 10550 3650 50  0000 C CNN
F 1 "Conn_01x01" H 10550 3450 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 3550 50  0001 C CNN
F 3 "" H 10550 3550 50  0001 C CNN
	1    10550 3550
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J14
U 1 1 59C4B3C6
P 10550 3650
F 0 "J14" H 10550 3750 50  0000 C CNN
F 1 "Conn_01x01" H 10550 3550 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 3650 50  0001 C CNN
F 3 "" H 10550 3650 50  0001 C CNN
	1    10550 3650
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J15
U 1 1 59C4B44E
P 10550 3750
F 0 "J15" H 10550 3850 50  0000 C CNN
F 1 "Conn_01x01" H 10550 3650 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 3750 50  0001 C CNN
F 3 "" H 10550 3750 50  0001 C CNN
	1    10550 3750
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J16
U 1 1 59C4B4BB
P 10550 3850
F 0 "J16" H 10550 3950 50  0000 C CNN
F 1 "Conn_01x01" H 10550 3750 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 3850 50  0001 C CNN
F 3 "" H 10550 3850 50  0001 C CNN
	1    10550 3850
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J17
U 1 1 59C4B52B
P 10550 3950
F 0 "J17" H 10550 4050 50  0000 C CNN
F 1 "Conn_01x01" H 10550 3850 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 3950 50  0001 C CNN
F 3 "" H 10550 3950 50  0001 C CNN
	1    10550 3950
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J18
U 1 1 59C4B5A2
P 10550 4050
F 0 "J18" H 10550 4150 50  0000 C CNN
F 1 "Conn_01x01" H 10550 3950 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 4050 50  0001 C CNN
F 3 "" H 10550 4050 50  0001 C CNN
	1    10550 4050
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J19
U 1 1 59C4B6C2
P 10550 4150
F 0 "J19" H 10550 4250 50  0000 C CNN
F 1 "Conn_01x01" H 10550 4050 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 4150 50  0001 C CNN
F 3 "" H 10550 4150 50  0001 C CNN
	1    10550 4150
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J20
U 1 1 59C4B73B
P 10550 4250
F 0 "J20" H 10550 4350 50  0000 C CNN
F 1 "Conn_01x01" H 10550 4150 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 4250 50  0001 C CNN
F 3 "" H 10550 4250 50  0001 C CNN
	1    10550 4250
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J21
U 1 1 59C4B7B7
P 10550 4350
F 0 "J21" H 10550 4450 50  0000 C CNN
F 1 "Conn_01x01" H 10550 4250 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 4350 50  0001 C CNN
F 3 "" H 10550 4350 50  0001 C CNN
	1    10550 4350
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J22
U 1 1 59C4B836
P 10550 4450
F 0 "J22" H 10550 4550 50  0000 C CNN
F 1 "Conn_01x01" H 10550 4350 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10550 4450 50  0001 C CNN
F 3 "" H 10550 4450 50  0001 C CNN
	1    10550 4450
	1    0    0    -1  
$EndComp
Wire Wire Line
	9950 4450 10350 4450
Wire Wire Line
	9950 4350 10350 4350
Wire Wire Line
	9950 4250 10350 4250
Wire Wire Line
	9950 4150 10350 4150
Wire Wire Line
	9950 4050 10350 4050
Wire Wire Line
	9950 3950 10350 3950
Wire Wire Line
	9950 3850 10350 3850
Wire Wire Line
	9950 3750 10350 3750
Wire Wire Line
	9950 3650 10350 3650
Wire Wire Line
	9950 3550 10350 3550
Wire Wire Line
	9950 3450 10350 3450
Wire Wire Line
	9950 3350 10350 3350
Wire Wire Line
	9950 3250 10350 3250
Wire Wire Line
	9950 3150 10350 3150
Wire Wire Line
	9950 2950 10350 2950
Wire Wire Line
	9950 3050 10350 3050
$Comp
L PWR_FLAG #FLG016
U 1 1 59C4CC7B
P 2700 6250
F 0 "#FLG016" H 2700 6325 50  0001 C CNN
F 1 "PWR_FLAG" H 2700 6400 50  0000 C CNN
F 2 "" H 2700 6250 50  0001 C CNN
F 3 "" H 2700 6250 50  0001 C CNN
	1    2700 6250
	1    0    0    -1  
$EndComp
Connection ~ 2700 6450
$Comp
L GND #PWR017
U 1 1 59C4DC2B
P 1750 2250
F 0 "#PWR017" H 1750 2000 50  0001 C CNN
F 1 "GND" H 1750 2100 50  0000 C CNN
F 2 "" H 1750 2250 50  0001 C CNN
F 3 "" H 1750 2250 50  0001 C CNN
	1    1750 2250
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR018
U 1 1 59C4DE54
P 2000 1100
F 0 "#PWR018" H 2000 950 50  0001 C CNN
F 1 "VCC" H 2000 1250 50  0000 C CNN
F 2 "" H 2000 1100 50  0001 C CNN
F 3 "" H 2000 1100 50  0001 C CNN
	1    2000 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	1550 1850 1750 1850
Wire Wire Line
	1750 1350 1750 2250
$Comp
L VCC #PWR019
U 1 1 59C4E307
P 1700 6600
F 0 "#PWR019" H 1700 6450 50  0001 C CNN
F 1 "VCC" H 1700 6750 50  0000 C CNN
F 2 "" H 1700 6600 50  0001 C CNN
F 3 "" H 1700 6600 50  0001 C CNN
	1    1700 6600
	1    0    0    -1  
$EndComp
Wire Wire Line
	1700 6600 1700 6700
Wire Wire Line
	2000 1100 2000 1750
Wire Wire Line
	4350 2600 4800 2600
Wire Wire Line
	7650 1250 8250 1250
$Comp
L R R2
U 1 1 59C50F45
P 2600 1650
F 0 "R2" V 2680 1650 50  0000 C CNN
F 1 "680" V 2600 1650 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 2530 1650 50  0001 C CNN
F 3 "" H 2600 1650 50  0001 C CNN
	1    2600 1650
	0    1    1    0   
$EndComp
Wire Wire Line
	1550 1650 2450 1650
$Comp
L R R5
U 1 1 59C512D3
P 2600 1550
F 0 "R5" V 2680 1550 50  0000 C CNN
F 1 "680" V 2600 1550 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 2530 1550 50  0001 C CNN
F 3 "" H 2600 1550 50  0001 C CNN
	1    2600 1550
	0    -1   -1   0   
$EndComp
Wire Wire Line
	1550 1550 2450 1550
Text Label 6850 2750 2    60   ~ 0
ST/Rx
Text Label 6850 2600 2    60   ~ 0
OUT
Wire Wire Line
	3050 1650 2750 1650
Text Label 3050 1650 2    60   ~ 0
ST/Rx
Wire Wire Line
	2750 1550 3050 1550
Text Label 3050 1550 2    60   ~ 0
OUT
$Comp
L PWR_FLAG #FLG020
U 1 1 59C5625A
P 2400 1100
F 0 "#FLG020" H 2400 1175 50  0001 C CNN
F 1 "PWR_FLAG" H 2400 1250 50  0000 C CNN
F 2 "" H 2400 1100 50  0001 C CNN
F 3 "" H 2400 1100 50  0001 C CNN
	1    2400 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	2400 1450 2400 1100
Wire Wire Line
	1550 1450 2400 1450
Connection ~ 2000 1450
$Comp
L Conn_01x01 J6
U 1 1 59C4B6A6
P 9450 5850
F 0 "J6" H 9450 5950 50  0000 C CNN
F 1 "+LED" H 9600 5850 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 9450 5850 50  0001 C CNN
F 3 "" H 9450 5850 50  0001 C CNN
	1    9450 5850
	0    -1   -1   0   
$EndComp
$Comp
L Conn_01x01 J23
U 1 1 59C4B79E
P 9650 5850
F 0 "J23" H 9650 5950 50  0000 C CNN
F 1 "+LED" H 9800 5850 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 9650 5850 50  0001 C CNN
F 3 "" H 9650 5850 50  0001 C CNN
	1    9650 5850
	0    -1   -1   0   
$EndComp
$Comp
L Conn_01x01 J24
U 1 1 59C4BD3B
P 9850 5850
F 0 "J24" H 9850 5950 50  0000 C CNN
F 1 "+LED" H 10000 5850 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 9850 5850 50  0001 C CNN
F 3 "" H 9850 5850 50  0001 C CNN
	1    9850 5850
	0    -1   -1   0   
$EndComp
$Comp
L Conn_01x01 J25
U 1 1 59C4BDD3
P 10050 5850
F 0 "J25" H 10050 5950 50  0000 C CNN
F 1 "+LED" H 10200 5850 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10050 5850 50  0001 C CNN
F 3 "" H 10050 5850 50  0001 C CNN
	1    10050 5850
	0    -1   -1   0   
$EndComp
$Comp
L VCC #PWR021
U 1 1 59C4C32D
P 8850 5950
F 0 "#PWR021" H 8850 5800 50  0001 C CNN
F 1 "VCC" H 8850 6100 50  0000 C CNN
F 2 "" H 8850 5950 50  0001 C CNN
F 3 "" H 8850 5950 50  0001 C CNN
	1    8850 5950
	1    0    0    -1  
$EndComp
Wire Wire Line
	8850 5950 8850 6250
Wire Wire Line
	8850 6250 10450 6250
Wire Wire Line
	9450 6250 9450 6050
Wire Wire Line
	9650 6250 9650 6050
Connection ~ 9450 6250
Wire Wire Line
	9850 6250 9850 6050
Connection ~ 9650 6250
Wire Wire Line
	10050 6250 10050 6050
Connection ~ 9850 6250
$Comp
L Q_NMOS_GSD Q1
U 1 1 59C4D834
P 8450 1250
F 0 "Q1" H 8650 1300 50  0000 L CNN
F 1 "MOSFET 20V 3A" H 8650 1200 50  0000 L CNN
F 2 "TO_SOT_Packages_SMD:SOT-23" H 8650 1350 50  0001 C CNN
F 3 "" H 8450 1250 50  0001 C CNN
	1    8450 1250
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J26
U 1 1 59DB376D
P 10250 5850
F 0 "J26" H 10250 5950 50  0000 C CNN
F 1 "+LED" H 10400 5850 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10250 5850 50  0001 C CNN
F 3 "" H 10250 5850 50  0001 C CNN
	1    10250 5850
	0    -1   -1   0   
$EndComp
$Comp
L Conn_01x01 J27
U 1 1 59DB380B
P 10450 5850
F 0 "J27" H 10450 5950 50  0000 C CNN
F 1 "+LED" H 10600 5850 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 10450 5850 50  0001 C CNN
F 3 "" H 10450 5850 50  0001 C CNN
	1    10450 5850
	0    -1   -1   0   
$EndComp
Wire Wire Line
	10250 6250 10250 6050
Connection ~ 10050 6250
Wire Wire Line
	10450 6250 10450 6050
Connection ~ 10250 6250
$Comp
L TEST TP4
U 1 1 59DB5CFC
P 6000 6700
F 0 "TP4" V 6000 6900 50  0000 L BNN
F 1 "GND" V 6050 6900 50  0000 L CNN
F 2 "Measurement_Points:Measurement_Point_Round-SMD-Pad_Small" H 6000 6700 50  0001 C CNN
F 3 "" H 6000 6700 50  0001 C CNN
	1    6000 6700
	0    1    1    0   
$EndComp
$Comp
L GND #PWR022
U 1 1 59DB5EB3
P 6000 6800
F 0 "#PWR022" H 6000 6550 50  0001 C CNN
F 1 "GND" H 6000 6650 50  0000 C CNN
F 2 "" H 6000 6800 50  0001 C CNN
F 3 "" H 6000 6800 50  0001 C CNN
	1    6000 6800
	1    0    0    -1  
$EndComp
Wire Wire Line
	6000 6700 6000 6800
Wire Wire Line
	1550 1350 1750 1350
Connection ~ 1750 1850
Wire Wire Line
	2000 1750 1550 1750
$Comp
L LED_ALT D3
U 1 1 59DC7006
P 8050 1800
F 0 "D3" H 8050 1900 50  0000 C CNN
F 1 "LED" H 8050 1700 50  0000 C CNN
F 2 "LEDs:LED_0805_HandSoldering" H 8050 1800 50  0001 C CNN
F 3 "" H 8050 1800 50  0001 C CNN
	1    8050 1800
	0    -1   -1   0   
$EndComp
$Comp
L R R6
U 1 1 59DC70B5
P 8050 1450
F 0 "R6" V 8130 1450 50  0000 C CNN
F 1 "1k2" V 8050 1450 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 7980 1450 50  0001 C CNN
F 3 "" H 8050 1450 50  0001 C CNN
	1    8050 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	8050 1600 8050 1650
$Comp
L GND #PWR023
U 1 1 59DC74AB
P 8050 2000
F 0 "#PWR023" H 8050 1750 50  0001 C CNN
F 1 "GND" H 8050 1850 50  0000 C CNN
F 2 "" H 8050 2000 50  0001 C CNN
F 3 "" H 8050 2000 50  0001 C CNN
	1    8050 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	8050 1950 8050 2000
Wire Wire Line
	2000 2100 2000 2150
Wire Wire Line
	2000 2150 1750 2150
Connection ~ 1750 2150
Text Label 4350 3650 0    60   ~ 0
XLAT
Text Label 4350 2600 0    60   ~ 0
OUT15
$Comp
L GS2 J4
U 1 1 59DCA798
P 2450 6950
F 0 "J4" H 2550 7100 50  0000 C CNN
F 1 "GS2" H 2550 6801 50  0000 C CNN
F 2 "SMD-pads:SMD_solder_jumper_2pin" V 2524 6950 50  0001 C CNN
F 3 "" H 2450 6950 50  0001 C CNN
	1    2450 6950
	0    1    1    0   
$EndComp
Wire Wire Line
	2700 6950 2650 6950
Wire Wire Line
	2250 6950 2200 6950
Wire Wire Line
	2200 6950 2200 6700
Connection ~ 2200 6700
Wire Wire Line
	9250 4750 9250 5000
Wire Wire Line
	9150 4750 9150 4900
Wire Wire Line
	9150 4900 9250 4900
Connection ~ 9250 4900
$Comp
L SAMD11D14A-M U3
U 1 1 5A0E73D9
P 5700 3350
F 0 "U3" H 6300 2250 60  0000 C CNN
F 1 "SAMD11D14A-M" H 5700 3600 60  0000 C CNN
F 2 "Housings_DFN_QFN:QFN-24_4x4mm_Pitch0.5mm" H 5700 3250 60  0001 C CNN
F 3 "" H 5700 3250 60  0001 C CNN
	1    5700 3350
	1    0    0    -1  
$EndComp
Text Label 8150 3250 0    60   ~ 0
GSCLK
Wire Wire Line
	6550 2600 6850 2600
Wire Wire Line
	6550 2750 6850 2750
NoConn ~ 4800 3800
NoConn ~ 4800 3950
NoConn ~ 6550 3050
NoConn ~ 4800 4250
Text Label 4350 3350 0    60   ~ 0
BLANK
Wire Wire Line
	4800 2900 4350 2900
Text Label 4350 2900 0    60   ~ 0
TH/Tx
Text Label 4350 3050 0    60   ~ 0
GSCLK
Wire Wire Line
	6550 4100 6850 4100
Wire Wire Line
	6550 4250 6850 4250
Text Label 6850 4100 2    60   ~ 0
SWCLK
Text Label 6850 4250 2    60   ~ 0
SWDIO
Text Label 5550 5950 0    60   ~ 0
SWCLK
Text Label 5550 6200 0    60   ~ 0
SWDIO
Text Label 5550 6450 0    60   ~ 0
RESET
Wire Wire Line
	4800 4400 4350 4400
Text Label 4350 4400 0    60   ~ 0
RESET
Wire Wire Line
	4800 3500 4350 3500
Text Label 4350 3500 0    60   ~ 0
CH3
$Comp
L GND #PWR024
U 1 1 5A0ED963
P 1250 3950
F 0 "#PWR024" H 1250 3700 50  0001 C CNN
F 1 "GND" H 1250 3800 50  0000 C CNN
F 2 "" H 1250 3950 50  0001 C CNN
F 3 "" H 1250 3950 50  0001 C CNN
	1    1250 3950
	1    0    0    -1  
$EndComp
Wire Wire Line
	1250 3850 1250 3950
Text Label 1250 3150 3    60   ~ 0
Button
Text Label 8150 3450 0    60   ~ 0
BLANK
Text Label 8150 3550 0    60   ~ 0
XLAT
Wire Wire Line
	8550 4250 8150 4250
Wire Wire Line
	8550 4350 8150 4350
Text Label 8150 4250 0    60   ~ 0
SCLK
Text Label 8150 4350 0    60   ~ 0
SIN
Wire Wire Line
	7750 3050 7750 3150
Wire Wire Line
	6000 5950 5550 5950
Wire Wire Line
	6000 6200 5550 6200
Wire Wire Line
	6000 6450 5550 6450
Wire Wire Line
	8050 1300 8050 1250
Connection ~ 8050 1250
Text Label 7650 1250 0    60   ~ 0
OUT15
$Comp
L Conn_01x06_Male J1
U 1 1 5A0F5BA3
P 1350 1650
F 0 "J1" H 1350 1950 50  0000 C CNN
F 1 "Conn_01x06_Male" H 1350 1250 50  0000 C CNN
F 2 "SMD-pads:CONN_6_SMD_FLAT" H 1350 1650 50  0001 C CNN
F 3 "" H 1350 1650 50  0001 C CNN
	1    1350 1650
	1    0    0    1   
$EndComp
NoConn ~ 4350 3500
NoConn ~ 4350 2900
Wire Wire Line
	6550 3350 6850 3350
Text Label 6850 3350 2    60   ~ 0
SCLK
Text Label 6850 3200 2    60   ~ 0
SIN
Wire Wire Line
	6850 3200 6550 3200
Wire Wire Line
	4800 2750 4350 2750
Text Label 4350 2750 0    60   ~ 0
BUTTON
Wire Wire Line
	6550 2900 6850 2900
NoConn ~ 6850 2900
Wire Wire Line
	4800 3200 4350 3200
NoConn ~ 4350 3200
Text Notes 3500 4800 0    59   ~ 0
Do not use PA10, PA11, PA17, PA27 \nfor compatibility with SOIC-20
Wire Wire Line
	6100 2200 6150 2200
Wire Wire Line
	6150 2200 6150 2250
Text Label 2250 5050 0    60   ~ 0
VUSB
Text Label 2150 5250 0    60   ~ 0
DP_IN
Text Label 2150 5350 0    60   ~ 0
DM_IN
Text Label 2700 6300 0    60   ~ 0
V_IN
Text Label 7850 3050 0    60   ~ 0
IREF
$EndSCHEMATC