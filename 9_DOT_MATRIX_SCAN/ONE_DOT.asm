GREENCOL EQU 0FFC5H
REDCOL 	 EQU 0FFC6H
ROW 	 EQU 0FFC7H

	ORG 8000H

init:
	MOV R0, #00000001B
	MOV R1, #00000001B
	MOV R2, #00000000B
	CLR C

mainLoop:
	CALL columnLoop
	CALL advanceColumn
	SJMP mainLoop

columnLoop:
	CALL displayDots
	CALL delay
	MOV A, R0
	RLC A
	MOV R0, A
	JNC columnLoop
	RET

advanceColumn: 
	MOV A, R1
	RL A
	MOV R1, A
	RET

delay:
	MOV R5, #7h
DELAY1: MOV R6, #0FFh
DELAY2: MOV R7, #0FFh
DELAY3: DJNZ R7, DELAY3
	DJNZ R6, DELAY2
	DJNZ R5, DELAY1
	RET

displayDots:
	MOV DPTR, #ROW
	MOV A, R0
	MOVX @DPTR, A
	MOV DPTR, #GREENCOL
	MOV A, R1
	MOVX @DPTR, A
	MOV DPTR, #REDCOL
	MOV A, R2
	MOVX @DPTR, A
	RET


