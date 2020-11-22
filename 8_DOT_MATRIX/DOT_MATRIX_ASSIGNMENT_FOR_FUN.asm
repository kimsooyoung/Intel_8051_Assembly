GREENCOL EQU 0FFC5H
REDCOL 	 EQU 0FFC6H
ROW 	 EQU 0FFC7H

	ORG 8000H

; MAIN LOOP
MainLoop:
	;CALL KEYSCAN
	CALL INITGREEN
	CALL LOOPGREEN
	CALL INITRED
	CALL LOOPRED
	SJMP MainLoop

INITGREEN:
	MOV R0, #00000001B
	MOV R1, #00000001B
	MOV R2, #00000000B
	CLR C
	RET

INITRED:
	MOV R0, #00000001B
	MOV R1, #00000000B
	MOV R2, #00000001B
	CLR C
	RET

INNERGREEN:
	MOV A, R0
	RLC A
	MOV R0, A
	
	MOV R1, #00000001B
	JNC LOOPGREEN

	RET

LOOPGREEN:
	CALL DISPLAYDOT
	CALL DELAY
	
	MOV A, R1
	RLC A
	MOV R1, A

	JNC LOOPGREEN
	CLR C
	CALL INNERGREEN
	RET

INNERRED:
	MOV A, R0
	RLC A
	MOV R0, A
	
	MOV R2, #00000001B
	JNC LOOPRED

	RET

LOOPRED:
	CALL DISPLAYDOT
	CALL DELAY
	
	MOV A, R2
	RLC A
	MOV R2, A

	JNC LOOPRED
	CLR C
	CALL INNERRED
	RET


;Turn off all Dots
SetDotsOff:
	MOV R0, #00H
	MOV R1, #00H
	MOV R2, #00H

	CALL DISPLAYDOT
	RET

; SELECT THE GREEN COLOR
SetDotsGreen:
	MOV R0, #0FFH
	MOV R1, #0FFH
	MOV R2, #00H

	CALL DISPLAYDOT
	RET
	
; SELECT THE RED COLOR
SetDotsRed:
	MOV R0, #0FFH
	MOV R1, #00H
	MOV R2, #0FFH

	CALL DISPLAYDOT
	RET

; SELECT BOTH GREEN+RED COLOR
SetDotsGreenRed:
	MOV R0, #0FFH
	MOV R1, #0FFH
	MOV R2, #0FFH

	CALL DISPLAYDOT
	RET


DISPLAYDOT:
	MOV DPTR, #GREENCOL
	MOV A, R1
	MOVX @DPTR, A

	MOV DPTR, #REDCOL
	MOV A, R2
	MOVX @DPTR, A

	MOV DPTR, #ROW
	MOV A, R0
	MOVX @DPTR, A
	RET

Delay: MOV R5, #1
DELAY1: MOV R6, #0FFH
DELAY2: MOV R7, #0FFH
DELAY3: DJNZ R7, DELAY3
	DJNZ R6, DELAY2
	DJNZ R5, DELAY1
	RET

