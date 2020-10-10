ORG 8000H

SEG1 EQU 0FFC3H
SEG2 EQU 0FFC2H
SEG3 EQU 0FFC1H

START:
	MOV R0, #00H
	MOV R1, #99H
	MOV R2, #99H
	
	CALL INCREMENT_ARRAY
	CALL INCREMENT_ARRAY
	CALL INCREMENT_ARRAY

	CALL DISPLAY_SEGMENT

	JMP $

INCREMENT_R0:
	MOV A, R0
	INC A
	DA A
	MOV R0, A
	RET

INCREMENT_R1:
	MOV A, R1
	INC A
	DA A
	MOV R1, A
	RET

INCREMENT_R2:
	MOV A, R2
	INC A
	DA A
	MOV R2, A
	RET

INCREMENT_ARRAY:
	CALL INCREMENT_R2
	CJNE R2, #00H, FINISH
	CALL INCREMENT_R1
	CJNE R1, #00H, FINISH
	CALL INCREMENT_R0
	
FINISH:
	RET

DISPLAY_SEGMENT:
	MOV A, R0
	MOV DPTR, #SEG1
	MOVX @DPTR, A

	MOV A, R1
	MOV DPTR, #SEG2
	MOVX @DPTR, A

	MOV A, R2
	MOV DPTR, #SEG3
	MOVX @DPTR, A

	RET