	ORG 8000H
	; Memory Location of 7-Segment Disp
	SEVENSEG EQU 0FFC0H

; Initialize Accumulator and Carry Bit
START:
	MOV A, #11111111B

; Main Loop	
LOOP:
	CALL DISPLAY
	CALL DELAY
	RLC A
	JMP LOOP

; Delay Function
DELAY:	MOV R0, #0FFH
DELAY1: MOV R1, #0FFH
DELAY2: MOV R2, #002H

DELAY3: DJNZ R2, DELAY3
	DJNZ R1, DELAY2
	DJNZ R0, DELAY1
	RET

; Display Accum to 7-Segment Function
DISPLAY:
	MOV DPTR, #SEVENSEG
	MOVX @DPTR, A
	RET