	ORG 8000H
	DATAOUT EQU 0FFF0H
	DATAIN	EQU 0FFF1H
	
	DIGITMEM EQU 20H
	
	SEG1 EQU 0FFC3h
	SEG2 EQU 0FFC2h
	SEG3 EQU 0FFC1H

START:
	MOV R0, #DIGITMEM

	MOV @R0, #80H
	INC R0
	MOV @R0, #51H
	INC R0
	MOV @R0, #00H
	INC R0

mainLoop:
	CALL shiftLeft
	CALL display
	JMP mainLoop

shiftLeft:
	MOV A, #DIGITMEM
	MOV R1, A
	MOV A, @R1

	;; SWAP AND STORE
	SWAP A
	ANL A, #11110000
	MOV R5, A
	
	MOV A, R1
	INC A
	MOV R1, A
	MOV A, @R1
	ANL A, #11110000
	SWAP A
	
	ORL A, R5
	MOV R5, A

	MOV A, R1
	DEC A
	MOV R1, A

	MOV A, R5
	MOV @R1, A

shiftLeft2:
	MOV A, R1
	INC A
	MOV R1, A
	MOV A, @R1

	;; SWAP AND STORE
	SWAP A
	ANL A, #11110000
	MOV R5, A
	
	MOV A, R1
	INC A
	MOV R1, A
	MOV A, @R1
	ANL A, #11110000
	SWAP A
	
	ORL A, R5
	MOV R5, A

	MOV A, R1
	DEC A
	MOV R1, A

	MOV A, R5
	MOV @R1, A

shiftLeft3:
	MOV A, R1
	INC A
	MOV R1, A
	MOV A, @R1
	

display:
	MOV A, #DIGITMEM
	MOV R1, A
	MOV A, @R1

	MOV DPTR, #SEG1
	MOVX @DPTR, A
	
	MOV A, R1
	INC A
	MOV R1, A
	MOV A, @R1
	
	MOV DPTR, #SEG2
	MOVX @DPTR, A

	MOV A, R1
	INC A
	MOV R1, A
	MOV A, @R1
	
	MOV DPTR, #SEG3
	MOVX @DPTR, A

	RET

END