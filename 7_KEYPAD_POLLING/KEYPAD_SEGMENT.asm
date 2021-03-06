	ORG 8000H
	DATAOUT EQU 0FFF0H
	DATAIN	EQU 0FFF1H
	SEG3 	EQU 0FFC1H

mainLoop:
	CALL pollKeypad
	MOV A, R0
	JZ mainLoop
	CALL convert
	SUBB A, #10
	JNC mainLoop
	CALL display
	CALL delay
	JMP mainLoop

convert:
	MOV A, R0
	MOV R2, A
	SWAP A
	MOV R3, A
	; R2 COLUMN => - 1
	MOV A, R2
	DEC A
	ANL A, #00000011B
	MOV R2, A
	MOV A, R3
	DEC A
	ANL A, #00000011B
	; R3 
	MOV R3, A
	MOV A, R2
	; multiply 4 times => 0 4 8 
	RL A
	RL A
	ORL A, R3
	MOV R0, A
	RET

display:	
	MOV A, R1
	SWAP A
	ANL A, #11110000B
	ORL A, R0
	MOV DPTR, #SEG3
	MOVX @DPTR, A
	MOV R1, A
	RET

delay:
	MOV R5, #28H
DELAY1: MOV R6, #0FFh
DELAY2: MOV R7, #0FFh
DELAY3: DJNZ R7, DELAY3
	DJNZ R6, DELAY2
	DJNZ R5, DELAY1
	RET

pollKeypad:
	CALL initColumnOne

columnLoop:
	CALL sendColumnNumber
	CALL getRowNumber
	MOV A, R0
	JNZ keyPressFound
	CALL advanceColumn
	CJNE R7, #5, columnLoop

noKeyPressed:
	MOV R0, #0
	RET

keyPressFound:
	MOV R4, A
	MOV A, R7
	SWAP A
	ORL A, R4
	MOV R0, A
	RET

initColumnOne:
	MOV R7, #1
	MOV R6, #11101111b
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
	CJNE A, #11101111B checkRow2
	MOV R0, #1
	RET
checkRow2:
	MOV A, R5
	CJNE A, #11110111b checkRow3
	MOV R0, #2
	RET
checkRow3: 
	MOV A, R5
	CJNE A, #11111011B checkRow4
	MOV R0, #3
	RET
checkRow4: 
	MOV A, R5
	CJNE A, #11111101B checkRow5
	MOV R0, #4
	RET
checkRow5: 
	MOV A, R5
	CJNE A, #11111110B noRow
	MOV R0, #5
	RET
noRow:
	MOV R0, #0;
	RET
END