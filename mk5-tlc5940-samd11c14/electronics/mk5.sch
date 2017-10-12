EESchema Schematic File Version 2
LIBS:samd11c14a
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
P 8600 3650
F 0 "U4" H 8100 4525 50  0000 L CNN
F 1 "TLC5940PWP" H 8650 4525 50  0000 L CNN
F 2 "Housings_SSOP:HTSSOP-28_4.4x9.7mm_Pitch0.65mm_ThermalPad" H 8625 2675 50  0001 L CNN
F 3 "" H 8200 4350 50  0001 C CNN
	1    8600 3650
	1    0    0    -1  
$EndComp
$Comp
L SAMD11C14A U3
U 1 1 59C45A61
P 5050 3450
F 0 "U3" H 5600 2750 60  0000 C CNN
F 1 "SAMD11C14A" H 5050 3700 60  0000 C CNN
F 2 "Housings_SOIC:SOIC-14_3.9x8.7mm_Pitch1.27mm" H 5050 3350 60  0001 C CNN
F 3 "" H 5050 3350 60  0001 C CNN
	1    5050 3450
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
P 5050 4400
F 0 "#PWR01" H 5050 4150 50  0001 C CNN
F 1 "GND" H 5050 4250 50  0000 C CNN
F 2 "" H 5050 4400 50  0001 C CNN
F 3 "" H 5050 4400 50  0001 C CNN
	1    5050 4400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR02
U 1 1 59C45D7F
P 8600 5000
F 0 "#PWR02" H 8600 4750 50  0001 C CNN
F 1 "GND" H 8600 4850 50  0000 C CNN
F 2 "" H 8600 5000 50  0001 C CNN
F 3 "" H 8600 5000 50  0001 C CNN
	1    8600 5000
	1    0    0    -1  
$EndComp
$Comp
L +3V3 #PWR03
U 1 1 59C45E41
P 8600 2350
F 0 "#PWR03" H 8600 2200 50  0001 C CNN
F 1 "+3V3" H 8600 2490 50  0000 C CNN
F 2 "" H 8600 2350 50  0001 C CNN
F 3 "" H 8600 2350 50  0001 C CNN
	1    8600 2350
	1    0    0    -1  
$EndComp
$Comp
L +3V3 #PWR04
U 1 1 59C45E7A
P 5050 2400
F 0 "#PWR04" H 5050 2250 50  0001 C CNN
F 1 "+3V3" H 5050 2540 50  0000 C CNN
F 2 "" H 5050 2400 50  0001 C CNN
F 3 "" H 5050 2400 50  0001 C CNN
	1    5050 2400
	1    0    0    -1  
$EndComp
$Comp
L SW_Push SW1
U 1 1 59C45F57
P 6550 1900
F 0 "SW1" H 6600 2000 50  0000 L CNN
F 1 "BTN" H 6550 1840 50  0000 C CNN
F 2 "Buttons_Switches_SMD:SW_SPST_SKQG" H 6550 2100 50  0001 C CNN
F 3 "" H 6550 2100 50  0001 C CNN
	1    6550 1900
	0    1    1    0   
$EndComp
$Comp
L +3V3 #PWR05
U 1 1 59C46086
P 6550 1600
F 0 "#PWR05" H 6550 1450 50  0001 C CNN
F 1 "+3V3" H 6550 1740 50  0000 C CNN
F 2 "" H 6550 1600 50  0001 C CNN
F 3 "" H 6550 1600 50  0001 C CNN
	1    6550 1600
	1    0    0    -1  
$EndComp
$Comp
L TEST TP1
U 1 1 59C46169
P 6550 3700
F 0 "TP1" H 6550 4000 50  0000 C BNN
F 1 "SWCLK" H 6550 3950 50  0000 C CNN
F 2 "Measurement_Points:Measurement_Point_Round-SMD-Pad_Small" H 6550 3700 50  0001 C CNN
F 3 "" H 6550 3700 50  0001 C CNN
	1    6550 3700
	1    0    0    -1  
$EndComp
$Comp
L TEST TP2
U 1 1 59C46225
P 6850 3700
F 0 "TP2" H 6850 4000 50  0000 C BNN
F 1 "SWDIO" H 6850 3950 50  0000 C CNN
F 2 "Measurement_Points:Measurement_Point_Round-SMD-Pad_Small" H 6850 3700 50  0001 C CNN
F 3 "" H 6850 3700 50  0001 C CNN
	1    6850 3700
	1    0    0    -1  
$EndComp
$Comp
L TEST TP3
U 1 1 59C4652D
P 7150 3700
F 0 "TP3" H 7150 4000 50  0000 C BNN
F 1 "RESET" H 7150 3950 50  0000 C CNN
F 2 "Measurement_Points:Measurement_Point_Round-SMD-Pad_Small" H 7150 3700 50  0001 C CNN
F 3 "" H 7150 3700 50  0001 C CNN
	1    7150 3700
	1    0    0    -1  
$EndComp
Text Label 6200 3600 2    60   ~ 0
DP
Text Label 6200 3450 2    60   ~ 0
DM
$Comp
L GND #PWR06
U 1 1 59C46A64
P 4750 1800
F 0 "#PWR06" H 4750 1550 50  0001 C CNN
F 1 "GND" H 4750 1650 50  0000 C CNN
F 2 "" H 4750 1800 50  0001 C CNN
F 3 "" H 4750 1800 50  0001 C CNN
	1    4750 1800
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 59C46F6E
P 7550 3050
F 0 "R1" V 7630 3050 50  0000 C CNN
F 1 "2K" V 7550 3050 50  0000 C CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 7480 3050 50  0001 C CNN
F 3 "" H 7550 3050 50  0001 C CNN
	1    7550 3050
	0    1    1    0   
$EndComp
$Comp
L GND #PWR07
U 1 1 59C4705C
P 7350 3100
F 0 "#PWR07" H 7350 2850 50  0001 C CNN
F 1 "GND" H 7350 2950 50  0000 C CNN
F 2 "" H 7350 3100 50  0001 C CNN
F 3 "" H 7350 3100 50  0001 C CNN
	1    7350 3100
	1    0    0    -1  
$EndComp
$Comp
L C C4
U 1 1 59C47154
P 8850 2450
F 0 "C4" H 8875 2550 50  0000 L CNN
F 1 "100n" H 8875 2350 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 8888 2300 50  0001 C CNN
F 3 "" H 8850 2450 50  0001 C CNN
	1    8850 2450
	0    1    1    0   
$EndComp
$Comp
L C C3
U 1 1 59C471E5
P 5300 2500
F 0 "C3" H 5325 2600 50  0000 L CNN
F 1 "100n" H 5325 2400 50  0000 L CNN
F 2 "Capacitors_SMD:C_0603" H 5338 2350 50  0001 C CNN
F 3 "" H 5300 2500 50  0001 C CNN
	1    5300 2500
	0    1    1    0   
$EndComp
$Comp
L GND #PWR08
U 1 1 59C472D9
P 5500 2550
F 0 "#PWR08" H 5500 2300 50  0001 C CNN
F 1 "GND" H 5500 2400 50  0000 C CNN
F 2 "" H 5500 2550 50  0001 C CNN
F 3 "" H 5500 2550 50  0001 C CNN
	1    5500 2550
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR09
U 1 1 59C47427
P 9050 2500
F 0 "#PWR09" H 9050 2250 50  0001 C CNN
F 1 "GND" H 9050 2350 50  0000 C CNN
F 2 "" H 9050 2500 50  0001 C CNN
F 3 "" H 9050 2500 50  0001 C CNN
	1    9050 2500
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
L GND #PWR010
U 1 1 59C476EE
P 3650 7200
F 0 "#PWR010" H 3650 6950 50  0001 C CNN
F 1 "GND" H 3650 7050 50  0000 C CNN
F 2 "" H 3650 7200 50  0001 C CNN
F 3 "" H 3650 7200 50  0001 C CNN
	1    3650 7200
	1    0    0    -1  
$EndComp
$Comp
L +3V3 #PWR011
U 1 1 59C477CD
P 4150 6600
F 0 "#PWR011" H 4150 6450 50  0001 C CNN
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
L GND #PWR012
U 1 1 59C47A90
P 4150 7200
F 0 "#PWR012" H 4150 6950 50  0001 C CNN
F 1 "GND" H 4150 7050 50  0000 C CNN
F 2 "" H 4150 7200 50  0001 C CNN
F 3 "" H 4150 7200 50  0001 C CNN
	1    4150 7200
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR013
U 1 1 59C47B21
P 3100 7200
F 0 "#PWR013" H 3100 6950 50  0001 C CNN
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
F 1 "SS14" H 2450 6600 50  0000 C CNN
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
F 1 "SS14" H 2450 6350 50  0000 C CNN
F 2 "Diodes_SMD:D_SOD-323_HandSoldering" H 2450 6450 50  0001 C CNN
F 3 "" H 2450 6450 50  0001 C CNN
	1    2450 6450
	-1   0    0    1   
$EndComp
Wire Wire Line
	5050 4300 5050 4400
Wire Wire Line
	5050 2400 5050 2600
Wire Wire Line
	8600 2350 8600 2650
Wire Wire Line
	4050 3250 4150 3250
Wire Wire Line
	4050 2200 7100 2200
Wire Wire Line
	4050 2200 4050 3250
Wire Wire Line
	7100 2200 7100 3250
Wire Wire Line
	7100 3250 7900 3250
Wire Wire Line
	6550 1600 6550 1700
Wire Wire Line
	6850 4250 7900 4250
Wire Wire Line
	6850 3950 5900 3950
Wire Wire Line
	5900 3800 6550 3800
Wire Wire Line
	6550 3700 6550 4350
Wire Wire Line
	6550 4350 7900 4350
Connection ~ 6550 3800
Connection ~ 6850 3950
Wire Wire Line
	6850 3700 6850 4250
Wire Wire Line
	4150 3600 3900 3600
Wire Wire Line
	3900 3600 3900 4900
Wire Wire Line
	3900 4900 7600 4900
Wire Wire Line
	7600 4900 7600 3550
Wire Wire Line
	7600 3550 7900 3550
Wire Wire Line
	4150 3950 4050 3950
Wire Wire Line
	4050 3950 4050 4750
Wire Wire Line
	4050 4750 7400 4750
Wire Wire Line
	7400 4750 7400 3450
Wire Wire Line
	7400 3450 7900 3450
Wire Wire Line
	7150 3700 7150 3850
Wire Wire Line
	7150 3850 7400 3850
Connection ~ 7400 3850
Wire Wire Line
	5900 3450 6200 3450
Wire Wire Line
	5900 3600 6200 3600
Wire Wire Line
	4750 1700 4750 1800
Wire Wire Line
	4750 1150 4750 1300
Wire Wire Line
	7800 2450 8700 2450
Wire Wire Line
	7800 2450 7800 3150
Wire Wire Line
	7800 2950 7900 2950
Connection ~ 8600 2450
Wire Wire Line
	7800 3150 7900 3150
Connection ~ 7800 2950
Wire Wire Line
	7900 3050 7700 3050
Wire Wire Line
	7400 3050 7350 3050
Wire Wire Line
	7350 3050 7350 3100
Wire Wire Line
	5150 2500 5050 2500
Connection ~ 5050 2500
Wire Wire Line
	5450 2500 5500 2500
Wire Wire Line
	5500 2500 5500 2550
Wire Wire Line
	9000 2450 9050 2450
Wire Wire Line
	9050 2450 9050 2500
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
P 4750 950
F 0 "J3" H 4750 1050 50  0000 C CNN
F 1 "OUT15" H 4750 850 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 4750 950 50  0001 C CNN
F 3 "" H 4750 950 50  0001 C CNN
	1    4750 950 
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3000 3450 4150 3450
Wire Wire Line
	5900 2950 6200 2950
Wire Wire Line
	5900 3100 6200 3100
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
L GND #PWR014
U 1 1 59C49331
P 1650 5950
F 0 "#PWR014" H 1650 5700 50  0001 C CNN
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
L PWR_FLAG #FLG015
U 1 1 59C4A3FC
P 2100 4900
F 0 "#FLG015" H 2100 4975 50  0001 C CNN
F 1 "PWR_FLAG" H 2100 5050 50  0000 C CNN
F 2 "" H 2100 4900 50  0001 C CNN
F 3 "" H 2100 4900 50  0001 C CNN
	1    2100 4900
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG016
U 1 1 59C4A5F6
P 2000 2100
F 0 "#FLG016" H 2000 2175 50  0001 C CNN
F 1 "PWR_FLAG" H 2000 2250 50  0000 C CNN
F 2 "" H 2000 2100 50  0001 C CNN
F 3 "" H 2000 2100 50  0001 C CNN
	1    2000 2100
	1    0    0    -1  
$EndComp
NoConn ~ 7900 3850
NoConn ~ 7900 4450
$Comp
L Conn_01x01 J7
U 1 1 59C4AFD0
P 9900 2950
F 0 "J7" H 9900 3050 50  0000 C CNN
F 1 "Conn_01x01" H 9900 2850 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 9900 2950 50  0001 C CNN
F 3 "" H 9900 2950 50  0001 C CNN
	1    9900 2950
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J8
U 1 1 59C4B114
P 9900 3050
F 0 "J8" H 9900 3150 50  0000 C CNN
F 1 "Conn_01x01" H 9900 2950 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 9900 3050 50  0001 C CNN
F 3 "" H 9900 3050 50  0001 C CNN
	1    9900 3050
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J9
U 1 1 59C4B188
P 9900 3150
F 0 "J9" H 9900 3250 50  0000 C CNN
F 1 "Conn_01x01" H 9900 3050 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 9900 3150 50  0001 C CNN
F 3 "" H 9900 3150 50  0001 C CNN
	1    9900 3150
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J10
U 1 1 59C4B238
P 9900 3250
F 0 "J10" H 9900 3350 50  0000 C CNN
F 1 "Conn_01x01" H 9900 3150 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 9900 3250 50  0001 C CNN
F 3 "" H 9900 3250 50  0001 C CNN
	1    9900 3250
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J11
U 1 1 59C4B296
P 9900 3350
F 0 "J11" H 9900 3450 50  0000 C CNN
F 1 "Conn_01x01" H 9900 3250 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 9900 3350 50  0001 C CNN
F 3 "" H 9900 3350 50  0001 C CNN
	1    9900 3350
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J12
U 1 1 59C4B2F7
P 9900 3450
F 0 "J12" H 9900 3550 50  0000 C CNN
F 1 "Conn_01x01" H 9900 3350 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 9900 3450 50  0001 C CNN
F 3 "" H 9900 3450 50  0001 C CNN
	1    9900 3450
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J13
U 1 1 59C4B35F
P 9900 3550
F 0 "J13" H 9900 3650 50  0000 C CNN
F 1 "Conn_01x01" H 9900 3450 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 9900 3550 50  0001 C CNN
F 3 "" H 9900 3550 50  0001 C CNN
	1    9900 3550
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J14
U 1 1 59C4B3C6
P 9900 3650
F 0 "J14" H 9900 3750 50  0000 C CNN
F 1 "Conn_01x01" H 9900 3550 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 9900 3650 50  0001 C CNN
F 3 "" H 9900 3650 50  0001 C CNN
	1    9900 3650
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J15
U 1 1 59C4B44E
P 9900 3750
F 0 "J15" H 9900 3850 50  0000 C CNN
F 1 "Conn_01x01" H 9900 3650 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 9900 3750 50  0001 C CNN
F 3 "" H 9900 3750 50  0001 C CNN
	1    9900 3750
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J16
U 1 1 59C4B4BB
P 9900 3850
F 0 "J16" H 9900 3950 50  0000 C CNN
F 1 "Conn_01x01" H 9900 3750 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 9900 3850 50  0001 C CNN
F 3 "" H 9900 3850 50  0001 C CNN
	1    9900 3850
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J17
U 1 1 59C4B52B
P 9900 3950
F 0 "J17" H 9900 4050 50  0000 C CNN
F 1 "Conn_01x01" H 9900 3850 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 9900 3950 50  0001 C CNN
F 3 "" H 9900 3950 50  0001 C CNN
	1    9900 3950
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J18
U 1 1 59C4B5A2
P 9900 4050
F 0 "J18" H 9900 4150 50  0000 C CNN
F 1 "Conn_01x01" H 9900 3950 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 9900 4050 50  0001 C CNN
F 3 "" H 9900 4050 50  0001 C CNN
	1    9900 4050
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J19
U 1 1 59C4B6C2
P 9900 4150
F 0 "J19" H 9900 4250 50  0000 C CNN
F 1 "Conn_01x01" H 9900 4050 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 9900 4150 50  0001 C CNN
F 3 "" H 9900 4150 50  0001 C CNN
	1    9900 4150
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J20
U 1 1 59C4B73B
P 9900 4250
F 0 "J20" H 9900 4350 50  0000 C CNN
F 1 "Conn_01x01" H 9900 4150 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 9900 4250 50  0001 C CNN
F 3 "" H 9900 4250 50  0001 C CNN
	1    9900 4250
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J21
U 1 1 59C4B7B7
P 9900 4350
F 0 "J21" H 9900 4450 50  0000 C CNN
F 1 "Conn_01x01" H 9900 4250 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 9900 4350 50  0001 C CNN
F 3 "" H 9900 4350 50  0001 C CNN
	1    9900 4350
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J22
U 1 1 59C4B836
P 9900 4450
F 0 "J22" H 9900 4550 50  0000 C CNN
F 1 "Conn_01x01" H 9900 4350 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 9900 4450 50  0001 C CNN
F 3 "" H 9900 4450 50  0001 C CNN
	1    9900 4450
	1    0    0    -1  
$EndComp
Wire Wire Line
	9300 4450 9700 4450
Wire Wire Line
	9300 4350 9700 4350
Wire Wire Line
	9300 4250 9700 4250
Wire Wire Line
	9300 4150 9700 4150
Wire Wire Line
	9300 4050 9700 4050
Wire Wire Line
	9300 3950 9700 3950
Wire Wire Line
	9300 3850 9700 3850
Wire Wire Line
	9300 3750 9700 3750
Wire Wire Line
	9300 3650 9700 3650
Wire Wire Line
	9300 3550 9700 3550
Wire Wire Line
	9300 3450 9700 3450
Wire Wire Line
	9300 3350 9700 3350
Wire Wire Line
	9300 3250 9700 3250
Wire Wire Line
	9300 3150 9700 3150
Wire Wire Line
	9300 2950 9700 2950
Wire Wire Line
	9300 3050 9700 3050
Wire Wire Line
	2700 3100 4150 3100
$Comp
L PWR_FLAG #FLG017
U 1 1 59C4CC7B
P 2700 6250
F 0 "#FLG017" H 2700 6325 50  0001 C CNN
F 1 "PWR_FLAG" H 2700 6400 50  0000 C CNN
F 2 "" H 2700 6250 50  0001 C CNN
F 3 "" H 2700 6250 50  0001 C CNN
	1    2700 6250
	1    0    0    -1  
$EndComp
Connection ~ 2700 6450
$Comp
L GND #PWR018
U 1 1 59C4DC2B
P 1750 2250
F 0 "#PWR018" H 1750 2000 50  0001 C CNN
F 1 "GND" H 1750 2100 50  0000 C CNN
F 2 "" H 1750 2250 50  0001 C CNN
F 3 "" H 1750 2250 50  0001 C CNN
	1    1750 2250
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR019
U 1 1 59C4DE54
P 2000 1100
F 0 "#PWR019" H 2000 950 50  0001 C CNN
F 1 "VCC" H 2000 1250 50  0000 C CNN
F 2 "" H 2000 1100 50  0001 C CNN
F 3 "" H 2000 1100 50  0001 C CNN
	1    2000 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	1550 1850 1750 1850
Wire Wire Line
	1750 1150 1750 2250
$Comp
L VCC #PWR020
U 1 1 59C4E307
P 1700 6600
F 0 "#PWR020" H 1700 6450 50  0001 C CNN
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
	3900 2950 4150 2950
Wire Wire Line
	3900 1500 3900 2950
Wire Wire Line
	3650 1500 4450 1500
Wire Wire Line
	1550 1550 2700 1550
Wire Wire Line
	1550 1450 3000 1450
$Comp
L R R3
U 1 1 59C5077D
P 2700 2350
F 0 "R3" V 2780 2350 50  0000 C CNN
F 1 "680" V 2700 2350 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 2630 2350 50  0001 C CNN
F 3 "" H 2700 2350 50  0001 C CNN
	1    2700 2350
	1    0    0    -1  
$EndComp
$Comp
L R R4
U 1 1 59C50A24
P 3000 2350
F 0 "R4" V 3080 2350 50  0000 C CNN
F 1 "680" V 3000 2350 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 2930 2350 50  0001 C CNN
F 3 "" H 3000 2350 50  0001 C CNN
	1    3000 2350
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 59C50F45
P 2400 2350
F 0 "R2" V 2480 2350 50  0000 C CNN
F 1 "680" V 2400 2350 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 2330 2350 50  0001 C CNN
F 3 "" H 2400 2350 50  0001 C CNN
	1    2400 2350
	1    0    0    -1  
$EndComp
Wire Wire Line
	1550 1650 2400 1650
$Comp
L R R5
U 1 1 59C512D3
P 3300 2350
F 0 "R5" V 3380 2350 50  0000 C CNN
F 1 "680" V 3300 2350 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 3230 2350 50  0001 C CNN
F 3 "" H 3300 2350 50  0001 C CNN
	1    3300 2350
	1    0    0    -1  
$EndComp
Wire Wire Line
	1550 1350 3300 1350
Text Label 6200 3100 2    60   ~ 0
ST/Rx
Text Label 6200 2950 2    60   ~ 0
OUT
Wire Wire Line
	2700 2500 2700 3100
Wire Wire Line
	2400 2500 2400 2800
Text Label 2400 2800 1    60   ~ 0
ST/Rx
Text Label 2700 2800 1    60   ~ 0
TH/Tx
Wire Wire Line
	3000 2500 3000 3450
Text Label 3000 2800 1    60   ~ 0
CH3
Wire Wire Line
	3300 2500 3300 2800
Text Label 3300 2800 1    60   ~ 0
OUT
$Comp
L PWR_FLAG #FLG021
U 1 1 59C5625A
P 2400 1100
F 0 "#FLG021" H 2400 1175 50  0001 C CNN
F 1 "PWR_FLAG" H 2400 1250 50  0000 C CNN
F 2 "" H 2400 1100 50  0001 C CNN
F 3 "" H 2400 1100 50  0001 C CNN
	1    2400 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	2400 1250 2400 1100
Wire Wire Line
	1550 1250 2400 1250
Connection ~ 2000 1250
$Comp
L Conn_01x01 J6
U 1 1 59C4B6A6
P 7650 1150
F 0 "J6" H 7650 1250 50  0000 C CNN
F 1 "+LED" H 7800 1150 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 7650 1150 50  0001 C CNN
F 3 "" H 7650 1150 50  0001 C CNN
	1    7650 1150
	0    -1   -1   0   
$EndComp
$Comp
L Conn_01x01 J23
U 1 1 59C4B79E
P 7850 1150
F 0 "J23" H 7850 1250 50  0000 C CNN
F 1 "+LED" H 8000 1150 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 7850 1150 50  0001 C CNN
F 3 "" H 7850 1150 50  0001 C CNN
	1    7850 1150
	0    -1   -1   0   
$EndComp
$Comp
L Conn_01x01 J24
U 1 1 59C4BD3B
P 8050 1150
F 0 "J24" H 8050 1250 50  0000 C CNN
F 1 "+LED" H 8200 1150 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 8050 1150 50  0001 C CNN
F 3 "" H 8050 1150 50  0001 C CNN
	1    8050 1150
	0    -1   -1   0   
$EndComp
$Comp
L Conn_01x01 J25
U 1 1 59C4BDD3
P 8250 1150
F 0 "J25" H 8250 1250 50  0000 C CNN
F 1 "+LED" H 8400 1150 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 8250 1150 50  0001 C CNN
F 3 "" H 8250 1150 50  0001 C CNN
	1    8250 1150
	0    -1   -1   0   
$EndComp
$Comp
L VCC #PWR022
U 1 1 59C4C32D
P 7050 1250
F 0 "#PWR022" H 7050 1100 50  0001 C CNN
F 1 "VCC" H 7050 1400 50  0000 C CNN
F 2 "" H 7050 1250 50  0001 C CNN
F 3 "" H 7050 1250 50  0001 C CNN
	1    7050 1250
	1    0    0    -1  
$EndComp
Wire Wire Line
	7050 1250 7050 1550
Wire Wire Line
	7050 1550 8650 1550
Wire Wire Line
	7650 1550 7650 1350
Wire Wire Line
	7850 1550 7850 1350
Connection ~ 7650 1550
Wire Wire Line
	8050 1550 8050 1350
Connection ~ 7850 1550
Wire Wire Line
	8250 1550 8250 1350
Connection ~ 8050 1550
$Comp
L Q_NMOS_GSD Q1
U 1 1 59C4D834
P 4650 1500
F 0 "Q1" H 4850 1550 50  0000 L CNN
F 1 "MOSFET 20V 3A" H 4850 1450 50  0000 L CNN
F 2 "TO_SOT_Packages_SMD:SOT-23" H 4850 1600 50  0001 C CNN
F 3 "" H 4650 1500 50  0001 C CNN
	1    4650 1500
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x01 J26
U 1 1 59DB376D
P 8450 1150
F 0 "J26" H 8450 1250 50  0000 C CNN
F 1 "+LED" H 8600 1150 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 8450 1150 50  0001 C CNN
F 3 "" H 8450 1150 50  0001 C CNN
	1    8450 1150
	0    -1   -1   0   
$EndComp
$Comp
L Conn_01x01 J27
U 1 1 59DB380B
P 8650 1150
F 0 "J27" H 8650 1250 50  0000 C CNN
F 1 "+LED" H 8800 1150 50  0000 C CNN
F 2 "SMD-pads:SMD50x100" H 8650 1150 50  0001 C CNN
F 3 "" H 8650 1150 50  0001 C CNN
	1    8650 1150
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8450 1550 8450 1350
Connection ~ 8250 1550
Wire Wire Line
	8650 1550 8650 1350
Connection ~ 8450 1550
$Comp
L TEST TP4
U 1 1 59DB5CFC
P 6200 4400
F 0 "TP4" H 6200 4700 50  0000 C BNN
F 1 "GND" H 6200 4650 50  0000 C CNN
F 2 "Measurement_Points:Measurement_Point_Round-SMD-Pad_Small" H 6200 4400 50  0001 C CNN
F 3 "" H 6200 4400 50  0001 C CNN
	1    6200 4400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR023
U 1 1 59DB5EB3
P 6200 4500
F 0 "#PWR023" H 6200 4250 50  0001 C CNN
F 1 "GND" H 6200 4350 50  0000 C CNN
F 2 "" H 6200 4500 50  0001 C CNN
F 3 "" H 6200 4500 50  0001 C CNN
	1    6200 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	6200 4400 6200 4500
$Comp
L Conn_01x08_Male J1
U 1 1 59DC562F
P 1350 1550
F 0 "J1" H 1350 1950 50  0000 C CNN
F 1 "Conn_01x08_Male" H 1350 1050 50  0000 C CNN
F 2 "SMD-pads:CONN_8_SMD_FLAT" H 1350 1550 50  0001 C CNN
F 3 "" H 1350 1550 50  0001 C CNN
	1    1350 1550
	1    0    0    1   
$EndComp
Wire Wire Line
	1550 1150 1750 1150
Connection ~ 1750 1850
Wire Wire Line
	2000 1750 1550 1750
$Comp
L LED_ALT D3
U 1 1 59DC7006
P 3650 2350
F 0 "D3" H 3650 2450 50  0000 C CNN
F 1 "LED" H 3650 2250 50  0000 C CNN
F 2 "LEDs:LED_0805_HandSoldering" H 3650 2350 50  0001 C CNN
F 3 "" H 3650 2350 50  0001 C CNN
	1    3650 2350
	0    -1   -1   0   
$EndComp
$Comp
L R R6
U 1 1 59DC70B5
P 3650 1950
F 0 "R6" V 3730 1950 50  0000 C CNN
F 1 "1k2" V 3650 1950 50  0000 C CNN
F 2 "Resistors_SMD:R_0603" V 3580 1950 50  0001 C CNN
F 3 "" H 3650 1950 50  0001 C CNN
	1    3650 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	3650 2100 3650 2200
$Comp
L GND #PWR024
U 1 1 59DC74AB
P 3650 2650
F 0 "#PWR024" H 3650 2400 50  0001 C CNN
F 1 "GND" H 3650 2500 50  0000 C CNN
F 2 "" H 3650 2650 50  0001 C CNN
F 3 "" H 3650 2650 50  0001 C CNN
	1    3650 2650
	1    0    0    -1  
$EndComp
Wire Wire Line
	3650 2500 3650 2650
Wire Wire Line
	6550 2100 6550 2200
Connection ~ 6550 2200
Wire Wire Line
	3650 1800 3650 1500
Connection ~ 3900 1500
Wire Wire Line
	2000 2100 2000 2150
Wire Wire Line
	2000 2150 1750 2150
Connection ~ 1750 2150
Text Label 4250 4750 0    60   ~ 0
BLANK/RESET
Text Label 4250 4900 0    60   ~ 0
XLAT
Text Label 4400 2200 0    60   ~ 0
GSCLK
Text Label 7050 4250 0    60   ~ 0
SCK/SWCLK
Text Label 7050 4350 0    60   ~ 0
SIN/SWDIO
Text Label 3900 1900 0    60   ~ 0
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
	8600 4750 8600 5000
Wire Wire Line
	8500 4750 8500 4900
Wire Wire Line
	8500 4900 8600 4900
Connection ~ 8600 4900
Wire Wire Line
	2400 1650 2400 2200
Wire Wire Line
	2700 1550 2700 2200
Wire Wire Line
	3000 1450 3000 2200
Wire Wire Line
	3300 1350 3300 2200
$EndSCHEMATC
