	ORG 8000H
	; Memory Location of 7-Segment
	SEVENSEG EQU 0FFC0H
	; Memory Location of Digits
	DIGITMEM EQU 20H

START:
	; Starting Memory Location in R0 
	MOV R0, #DIGITMEM 

	; Store Digit Patterns in Memory
	MOV @R0, #0C0H
	INC R0
	MOV @R0, #0F9H
	INC R0
	MOV @R0, #0A4H
	INC R0
	MOV @R0, #0B0H
	INC R0
	MOV @R0, #99H
	INC R0
	MOV @R0, #92H
	INC R0
	MOV @R0, #82H
	INC R0
	MOV @R0, #0D8H
	INC R0
	MOV @R0, #80H
	INC R0
	MOV @R0, #90H
	INC R0

; Main Program
LOOP:
	; Choose Number 5 for Display
	MOV R1, #5

	; Get the Digit Pattern of 5
	; Load Pattern to the Accumulator
	CALL GETDIGIT

	CALL DISPLAY
	CALL DELAY
	JMP LOOP

DELAY: 	MOV R0, #0FFH
DELAY1: MOV R1, #0FFH
DELAY2: MOV R2, #02H

DELAY3: DJNZ R2, DELAY3
	DJNZ R1, DELAY2
	DJNZ R0, DELAY1
	RET

; Display from Accum to 7-Seg
DISPLAY:	
	MOV DPTR, #SEVENSEG
	MOVX @DPTR, A
	RET

; Get the Digit Pattern of R1
; Load pattern in the Accumulator
GETDIGIT:
	MOV A, #DIGITMEM
	ADD A, R1
	MOV R0, A
	MOV A, @R0
	RET

; Finish with an Infinite Loop
FINISH: JMP FINISH