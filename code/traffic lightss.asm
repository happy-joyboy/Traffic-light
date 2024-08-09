
_manual_mode:

;traffic lightss.c,23 :: 		void manual_mode() {
;traffic lightss.c,24 :: 		while (portb.b0 == 0) {  // Wait until manual mode is deactivated
L_manual_mode0:
	BTFSC      PORTB+0, 0
	GOTO       L_manual_mode1
;traffic lightss.c,25 :: 		portc = 0;
	CLRF       PORTC+0
;traffic lightss.c,26 :: 		portd = led[current_led];
	MOVF       _current_led+0, 0
	ADDLW      _led+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;traffic lightss.c,28 :: 		if (portb.b1 == 0) {  // Cycle through LED patterns on button press
	BTFSC      PORTB+0, 1
	GOTO       L_manual_mode2
;traffic lightss.c,29 :: 		portd = led[++current_led];
	INCF       _current_led+0, 1
	MOVF       _current_led+0, 0
	ADDLW      _led+0
	MOVWF      FSR
	MOVF       INDF+0, 0
	MOVWF      PORTD+0
;traffic lightss.c,30 :: 		for (counter = 0; counter <= 3; counter++) {
	CLRF       _counter+0
L_manual_mode3:
	MOVF       _counter+0, 0
	SUBLW      3
	BTFSS      STATUS+0, 0
	GOTO       L_manual_mode4
;traffic lightss.c,31 :: 		for (delay_count = 0; delay_count <= 50; delay_count++) {
	CLRF       _delay_count+0
L_manual_mode6:
	MOVF       _delay_count+0, 0
	SUBLW      50
	BTFSS      STATUS+0, 0
	GOTO       L_manual_mode7
;traffic lightss.c,32 :: 		portb.b2 = 0;
	BCF        PORTB+0, 2
;traffic lightss.c,33 :: 		portb.b3 = 1;
	BSF        PORTB+0, 3
;traffic lightss.c,34 :: 		portb.b4 = 0;
	BCF        PORTB+0, 4
;traffic lightss.c,35 :: 		portb.b5 = 1;
	BSF        PORTB+0, 5
;traffic lightss.c,37 :: 		portc = 0;
	CLRF       PORTC+0
;traffic lightss.c,38 :: 		delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_manual_mode9:
	DECFSZ     R13+0, 1
	GOTO       L_manual_mode9
	DECFSZ     R12+0, 1
	GOTO       L_manual_mode9
	NOP
	NOP
;traffic lightss.c,40 :: 		portb.b2 = 1;
	BSF        PORTB+0, 2
;traffic lightss.c,41 :: 		portb.b3 = 0;
	BCF        PORTB+0, 3
;traffic lightss.c,42 :: 		portb.b4 = 1;
	BSF        PORTB+0, 4
;traffic lightss.c,43 :: 		portb.b5 = 0;
	BCF        PORTB+0, 5
;traffic lightss.c,45 :: 		portc = (((3 - counter) % 10) << 4) | (((3 - counter) % 10) & 0x0F);
	MOVF       _counter+0, 0
	SUBLW      3
	MOVWF      R0+0
	CLRF       R0+1
	BTFSS      STATUS+0, 0
	DECF       R0+1, 1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      4
	MOVWF      R3+0
	MOVF       R0+0, 0
	MOVWF      R2+0
	MOVF       R3+0, 0
L__manual_mode34:
	BTFSC      STATUS+0, 2
	GOTO       L__manual_mode35
	RLF        R2+0, 1
	BCF        R2+0, 0
	ADDLW      255
	GOTO       L__manual_mode34
L__manual_mode35:
	MOVLW      15
	ANDWF      R0+0, 1
	MOVF       R0+0, 0
	IORWF      R2+0, 0
	MOVWF      PORTC+0
;traffic lightss.c,46 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_manual_mode10:
	DECFSZ     R13+0, 1
	GOTO       L_manual_mode10
	DECFSZ     R12+0, 1
	GOTO       L_manual_mode10
	NOP
;traffic lightss.c,31 :: 		for (delay_count = 0; delay_count <= 50; delay_count++) {
	INCF       _delay_count+0, 1
;traffic lightss.c,47 :: 		}
	GOTO       L_manual_mode6
L_manual_mode7:
;traffic lightss.c,30 :: 		for (counter = 0; counter <= 3; counter++) {
	INCF       _counter+0, 1
;traffic lightss.c,48 :: 		}
	GOTO       L_manual_mode3
L_manual_mode4:
;traffic lightss.c,49 :: 		current_led ++;
	INCF       _current_led+0, 1
;traffic lightss.c,50 :: 		}
L_manual_mode2:
;traffic lightss.c,52 :: 		if (current_led == LED_COUNT | portb.b0 == 1) {
	MOVF       _current_led+0, 0
	XORLW      4
	MOVLW      1
	BTFSS      STATUS+0, 2
	MOVLW      0
	MOVWF      R1+0
	BTFSC      PORTB+0, 0
	GOTO       L__manual_mode36
	BCF        3, 0
	GOTO       L__manual_mode37
L__manual_mode36:
	BSF        3, 0
L__manual_mode37:
	CLRF       R0+0
	BTFSC      3, 0
	INCF       R0+0, 1
	MOVF       R1+0, 0
	IORWF      R0+0, 1
	BTFSC      STATUS+0, 2
	GOTO       L_manual_mode11
;traffic lightss.c,53 :: 		current_led = 0;  // Reset LED index
	CLRF       _current_led+0
;traffic lightss.c,54 :: 		}
L_manual_mode11:
;traffic lightss.c,55 :: 		}
	GOTO       L_manual_mode0
L_manual_mode1:
;traffic lightss.c,56 :: 		}
L_end_manual_mode:
	RETURN
; end of _manual_mode

_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;traffic lightss.c,59 :: 		void interrupt() {
;traffic lightss.c,60 :: 		if (intf_bit == 1) {
	BTFSS      INTF_bit+0, BitPos(INTF_bit+0)
	GOTO       L_interrupt12
;traffic lightss.c,61 :: 		intf_bit = 0;
	BCF        INTF_bit+0, BitPos(INTF_bit+0)
;traffic lightss.c,62 :: 		portc=0;
	CLRF       PORTC+0
;traffic lightss.c,63 :: 		temp_portd = portd;
	MOVF       PORTD+0, 0
	MOVWF      _temp_portd+0
;traffic lightss.c,64 :: 		ledR1=1;
	BSF        PORTD+0, 0
;traffic lightss.c,65 :: 		ledG2=1;
	BSF        PORTD+0, 5
;traffic lightss.c,67 :: 		manual_mode();
	CALL       _manual_mode+0
;traffic lightss.c,68 :: 		portd = temp_portd;
	MOVF       _temp_portd+0, 0
	MOVWF      PORTD+0
;traffic lightss.c,69 :: 		}
L_interrupt12:
;traffic lightss.c,70 :: 		}
L_end_interrupt:
L__interrupt39:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_automatic_mode:

;traffic lightss.c,73 :: 		void automatic_mode() {
;traffic lightss.c,74 :: 		ledR1 = 1;
	BSF        PORTD+0, 0
;traffic lightss.c,75 :: 		ledG2 = 1;
	BSF        PORTD+0, 5
;traffic lightss.c,78 :: 		for (i=0; i < 23; i++) {
	CLRF       _i+0
L_automatic_mode13:
	MOVLW      23
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_automatic_mode14
;traffic lightss.c,79 :: 		l = 23 - i;
	MOVF       _i+0, 0
	SUBLW      23
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _l+0
;traffic lightss.c,81 :: 		if (l == 3) {
	MOVF       R1+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_automatic_mode16
;traffic lightss.c,82 :: 		rr = 3;
	MOVLW      3
	MOVWF      _rr+0
;traffic lightss.c,83 :: 		ledY2 = 1;
	BSF        PORTD+0, 4
;traffic lightss.c,84 :: 		ledG2 = 0;
	BCF        PORTD+0, 5
;traffic lightss.c,85 :: 		}
L_automatic_mode16:
;traffic lightss.c,87 :: 		for (delay_count = 0; delay_count <= 50; delay_count++) {
	CLRF       _delay_count+0
L_automatic_mode17:
	MOVF       _delay_count+0, 0
	SUBLW      50
	BTFSS      STATUS+0, 0
	GOTO       L_automatic_mode18
;traffic lightss.c,88 :: 		portb.b2 = 0;
	BCF        PORTB+0, 2
;traffic lightss.c,89 :: 		portb.b3 = 1;
	BSF        PORTB+0, 3
;traffic lightss.c,90 :: 		portb.b4 = 0;
	BCF        PORTB+0, 4
;traffic lightss.c,91 :: 		portb.b5 = 1;
	BSF        PORTB+0, 5
;traffic lightss.c,93 :: 		portc = ((rr / 10) << 4) | ((l / 10) & 0x0F);
	MOVLW      10
	MOVWF      R4+0
	MOVF       _rr+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      FLOC__automatic_mode+0
	RLF        FLOC__automatic_mode+0, 1
	BCF        FLOC__automatic_mode+0, 0
	RLF        FLOC__automatic_mode+0, 1
	BCF        FLOC__automatic_mode+0, 0
	RLF        FLOC__automatic_mode+0, 1
	BCF        FLOC__automatic_mode+0, 0
	RLF        FLOC__automatic_mode+0, 1
	BCF        FLOC__automatic_mode+0, 0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _l+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVLW      15
	ANDWF      R0+0, 1
	MOVF       R0+0, 0
	IORWF      FLOC__automatic_mode+0, 0
	MOVWF      PORTC+0
;traffic lightss.c,94 :: 		delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_automatic_mode20:
	DECFSZ     R13+0, 1
	GOTO       L_automatic_mode20
	DECFSZ     R12+0, 1
	GOTO       L_automatic_mode20
	NOP
	NOP
;traffic lightss.c,96 :: 		portb.b2 = 1;
	BSF        PORTB+0, 2
;traffic lightss.c,97 :: 		portb.b3 = 0;
	BCF        PORTB+0, 3
;traffic lightss.c,98 :: 		portb.b4 = 1;
	BSF        PORTB+0, 4
;traffic lightss.c,99 :: 		portb.b5 = 0;
	BCF        PORTB+0, 5
;traffic lightss.c,101 :: 		portc = ((rr % 10) << 4) | ((l % 10) & 0x0F);
	MOVLW      10
	MOVWF      R4+0
	MOVF       _rr+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      FLOC__automatic_mode+0
	RLF        FLOC__automatic_mode+0, 1
	BCF        FLOC__automatic_mode+0, 0
	RLF        FLOC__automatic_mode+0, 1
	BCF        FLOC__automatic_mode+0, 0
	RLF        FLOC__automatic_mode+0, 1
	BCF        FLOC__automatic_mode+0, 0
	RLF        FLOC__automatic_mode+0, 1
	BCF        FLOC__automatic_mode+0, 0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _l+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      15
	ANDWF      R0+0, 1
	MOVF       R0+0, 0
	IORWF      FLOC__automatic_mode+0, 0
	MOVWF      PORTC+0
;traffic lightss.c,102 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_automatic_mode21:
	DECFSZ     R13+0, 1
	GOTO       L_automatic_mode21
	DECFSZ     R12+0, 1
	GOTO       L_automatic_mode21
	NOP
;traffic lightss.c,87 :: 		for (delay_count = 0; delay_count <= 50; delay_count++) {
	INCF       _delay_count+0, 1
;traffic lightss.c,103 :: 		}
	GOTO       L_automatic_mode17
L_automatic_mode18:
;traffic lightss.c,104 :: 		rr--;
	DECF       _rr+0, 1
;traffic lightss.c,78 :: 		for (i=0; i < 23; i++) {
	INCF       _i+0, 1
;traffic lightss.c,105 :: 		}
	GOTO       L_automatic_mode13
L_automatic_mode14:
;traffic lightss.c,106 :: 		ledY2 = 0;
	BCF        PORTD+0, 4
;traffic lightss.c,107 :: 		ledR1 = 0;
	BCF        PORTD+0, 0
;traffic lightss.c,110 :: 		rr = 12;
	MOVLW      12
	MOVWF      _rr+0
;traffic lightss.c,111 :: 		ledR2 = 1;
	BSF        PORTD+0, 3
;traffic lightss.c,112 :: 		ledG1 = 1;
	BSF        PORTD+0, 2
;traffic lightss.c,113 :: 		for (i = 0; i < 15; i++) {
	CLRF       _i+0
L_automatic_mode22:
	MOVLW      15
	SUBWF      _i+0, 0
	BTFSC      STATUS+0, 0
	GOTO       L_automatic_mode23
;traffic lightss.c,114 :: 		l = 15 - i;
	MOVF       _i+0, 0
	SUBLW      15
	MOVWF      R1+0
	MOVF       R1+0, 0
	MOVWF      _l+0
;traffic lightss.c,116 :: 		if (l == 3) {
	MOVF       R1+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_automatic_mode25
;traffic lightss.c,117 :: 		rr = 3;
	MOVLW      3
	MOVWF      _rr+0
;traffic lightss.c,118 :: 		ledY1 = 1;
	BSF        PORTD+0, 1
;traffic lightss.c,119 :: 		ledG1 = 0;
	BCF        PORTD+0, 2
;traffic lightss.c,120 :: 		}
L_automatic_mode25:
;traffic lightss.c,122 :: 		for (delay_count = 0; delay_count <= 50; delay_count++) {
	CLRF       _delay_count+0
L_automatic_mode26:
	MOVF       _delay_count+0, 0
	SUBLW      50
	BTFSS      STATUS+0, 0
	GOTO       L_automatic_mode27
;traffic lightss.c,123 :: 		portb.b2 = 0;
	BCF        PORTB+0, 2
;traffic lightss.c,124 :: 		portb.b3 = 1;
	BSF        PORTB+0, 3
;traffic lightss.c,125 :: 		portb.b4 = 0;
	BCF        PORTB+0, 4
;traffic lightss.c,126 :: 		portb.b5 = 1;
	BSF        PORTB+0, 5
;traffic lightss.c,128 :: 		portc = ((l / 10) << 4) | ((rr / 10) & 0x0F);
	MOVLW      10
	MOVWF      R4+0
	MOVF       _l+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R0+0, 0
	MOVWF      FLOC__automatic_mode+0
	RLF        FLOC__automatic_mode+0, 1
	BCF        FLOC__automatic_mode+0, 0
	RLF        FLOC__automatic_mode+0, 1
	BCF        FLOC__automatic_mode+0, 0
	RLF        FLOC__automatic_mode+0, 1
	BCF        FLOC__automatic_mode+0, 0
	RLF        FLOC__automatic_mode+0, 1
	BCF        FLOC__automatic_mode+0, 0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _rr+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVLW      15
	ANDWF      R0+0, 1
	MOVF       R0+0, 0
	IORWF      FLOC__automatic_mode+0, 0
	MOVWF      PORTC+0
;traffic lightss.c,129 :: 		delay_ms(5);
	MOVLW      13
	MOVWF      R12+0
	MOVLW      251
	MOVWF      R13+0
L_automatic_mode29:
	DECFSZ     R13+0, 1
	GOTO       L_automatic_mode29
	DECFSZ     R12+0, 1
	GOTO       L_automatic_mode29
	NOP
	NOP
;traffic lightss.c,131 :: 		portb.b2 = 1;
	BSF        PORTB+0, 2
;traffic lightss.c,132 :: 		portb.b3 = 0;
	BCF        PORTB+0, 3
;traffic lightss.c,133 :: 		portb.b4 = 1;
	BSF        PORTB+0, 4
;traffic lightss.c,134 :: 		portb.b5 = 0;
	BCF        PORTB+0, 5
;traffic lightss.c,136 :: 		portc = ((l % 10) << 4) | ((rr % 10) & 0x0F);
	MOVLW      10
	MOVWF      R4+0
	MOVF       _l+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R0+0, 0
	MOVWF      FLOC__automatic_mode+0
	RLF        FLOC__automatic_mode+0, 1
	BCF        FLOC__automatic_mode+0, 0
	RLF        FLOC__automatic_mode+0, 1
	BCF        FLOC__automatic_mode+0, 0
	RLF        FLOC__automatic_mode+0, 1
	BCF        FLOC__automatic_mode+0, 0
	RLF        FLOC__automatic_mode+0, 1
	BCF        FLOC__automatic_mode+0, 0
	MOVLW      10
	MOVWF      R4+0
	MOVF       _rr+0, 0
	MOVWF      R0+0
	CALL       _Div_8X8_U+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVLW      15
	ANDWF      R0+0, 1
	MOVF       R0+0, 0
	IORWF      FLOC__automatic_mode+0, 0
	MOVWF      PORTC+0
;traffic lightss.c,137 :: 		delay_ms(10);
	MOVLW      26
	MOVWF      R12+0
	MOVLW      248
	MOVWF      R13+0
L_automatic_mode30:
	DECFSZ     R13+0, 1
	GOTO       L_automatic_mode30
	DECFSZ     R12+0, 1
	GOTO       L_automatic_mode30
	NOP
;traffic lightss.c,122 :: 		for (delay_count = 0; delay_count <= 50; delay_count++) {
	INCF       _delay_count+0, 1
;traffic lightss.c,138 :: 		}
	GOTO       L_automatic_mode26
L_automatic_mode27:
;traffic lightss.c,139 :: 		rr--;
	DECF       _rr+0, 1
;traffic lightss.c,113 :: 		for (i = 0; i < 15; i++) {
	INCF       _i+0, 1
;traffic lightss.c,140 :: 		}
	GOTO       L_automatic_mode22
L_automatic_mode23:
;traffic lightss.c,141 :: 		ledR2 = 0;
	BCF        PORTD+0, 3
;traffic lightss.c,142 :: 		ledY1 = 0;
	BCF        PORTD+0, 1
;traffic lightss.c,143 :: 		}
L_end_automatic_mode:
	RETURN
; end of _automatic_mode

_main:

;traffic lightss.c,146 :: 		void main() {
;traffic lightss.c,148 :: 		trisb = 0;
	CLRF       TRISB+0
;traffic lightss.c,149 :: 		trisb.b0 = 1;  // Set RB0 as input for manual mode trigger
	BSF        TRISB+0, 0
;traffic lightss.c,150 :: 		trisb.b1 = 1;  // Set RB1 as input for LED cycling
	BSF        TRISB+0, 1
;traffic lightss.c,151 :: 		trisc = 0;
	CLRF       TRISC+0
;traffic lightss.c,152 :: 		trisd = 0;
	CLRF       TRISD+0
;traffic lightss.c,155 :: 		portb.b2 = 1;
	BSF        PORTB+0, 2
;traffic lightss.c,156 :: 		portb.b4 = 1;
	BSF        PORTB+0, 4
;traffic lightss.c,157 :: 		portc = 0;
	CLRF       PORTC+0
;traffic lightss.c,158 :: 		portd = 0;
	CLRF       PORTD+0
;traffic lightss.c,161 :: 		gie_bit = 1;
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;traffic lightss.c,162 :: 		inte_bit = 1;
	BSF        INTE_bit+0, BitPos(INTE_bit+0)
;traffic lightss.c,163 :: 		intedg_bit = 0;
	BCF        INTEDG_bit+0, BitPos(INTEDG_bit+0)
;traffic lightss.c,164 :: 		option_reg.b7 = 0;
	BCF        OPTION_REG+0, 7
;traffic lightss.c,166 :: 		while (1) {
L_main31:
;traffic lightss.c,167 :: 		automatic_mode();  // Default to automatic mode
	CALL       _automatic_mode+0
;traffic lightss.c,168 :: 		}
	GOTO       L_main31
;traffic lightss.c,169 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
