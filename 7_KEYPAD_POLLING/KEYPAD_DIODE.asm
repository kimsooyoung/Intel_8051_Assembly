	ORG 8000H
	
	DATAOUT EQU 0FFF0H
	DATAIN  EQU 0FFF1H

mainLoop:
	CALL pollKeypad
	CALL display
	SJMP mainLoop

display:
	MOV A, R0
	XRL A, #11111111B ; INVERSE
	MOV P1, A
	RET

pollKeypad:
	CALL initColumnOne

columnLoop:
	CALL sendColumnNumber
	CALL getRowNumber
	MOV A, R1
	JNZ keyPressFound
	CALL advanceColumn
	CJNE R7, #6, columnLoop

noKeyPressed:
	MOV R0, #0
	RET

keyPressFound:
	MOV A, R7
	SWAP A
	RL A
	ORL A, R1
	MOV R0, A
	RET

initColumnOne:
	MOV R7, #1
	MOV R6, #11101111B
	RET

advanceColumn:
	INC R7
	MOV A, R6
	RR A
	MOV R6, A
	RET

sendColumnNumber:
	MOV A, R6
	MOV DPTR, #DATAOUT
	MOVX @DPTR, A
	RET

getRowNumber:
	MOV DPTR, #DATAIN
	MOVX A, @DPTR
	ORL A, #11100000B
	MOV R5, A

checkRow1:
	MOV A, R5
	CJNE A, #11101111B, checkRow2
	MOV R1, #1
	RET

checkRow2:
	MOV A, R5
	CJNE A, #11110111B, checkRow3
	MOV R1, #2
	RET

checkRow3:
	MOV A, R5
	CJNE A, #11111011B, checkRow4
	MOV R1, #3
	RET

checkRow4:
	MOV A, R5
	CJNE A, #11111101B, checkRow5
	MOV R1, #4
	RET

checkRow5:
	MOV A, R5
	CJNE A, #11111110B, noRow
	MOV R1, #5
	RET

noRow:
	MOV R1, #0
	RET

END