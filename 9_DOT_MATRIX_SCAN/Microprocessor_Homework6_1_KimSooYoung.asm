GREENCOL EQU 0FFC5H
REDCOL 	 EQU 0FFC6H
ROW 	 EQU 0FFC7H
TEMP	 EQU 30H

	ORG 8000H

;Main Loop
mainLoop:
	CALL initRow
	CALL rowLoop
	SJMP mainLoop

;Start at the first Row
initRow:
	MOV R0, #00000001B
	MOV R1, #00000000B
	MOV R2, #00000000B
	MOV R3, #00H
	CLR C
	RET

;Loop within One Column
rowLoop:
	CALL getRow
	CALL displayDots
	CALL delay
	CALL advanceRow
	JNC rowLoop
	RET

;Advance to the next Row
advanceRow:
	MOV A, R0
	RLC A
	MOV R0, A
	INC R3
	RET

;Copy the row from Memory to R2
getRow:
	MOV DPTR, #charNium
	MOV A, R3
	MOVC A, @A+DPTR
	MOV R2, A
	RET

; Delay Procedure
delay:
	MOV R5, #7h
DELAY1: MOV R6, #40h
DELAY2: DJNZ R6, DELAY2
	DJNZ R5, DELAY1
	RET

; Display the Dot Matrix
; from R0, R1 and R2
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

	; Caution, REVERSED order
	; Each row of the character
	charNium:
		;DB: DATA BYTE
		;Store Korean Character Nium
		DB 00H, 40H, 40H, 40H
		DB 40H, 40H, 7EH, 00H
