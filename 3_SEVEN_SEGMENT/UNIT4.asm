;Assignment 1: Write a program to display each number

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

	; Initialize number to display
	MOV R1, #0

; Main Program
LOOP:
	; Display R1 on the 7-Segment
	CALL GETDIGIT
	CALL DISPLAY

	; Wait one second
	CALL DELAY

	; Increment R1
	CALL INCRESE

	; Repeat the Loop
	JMP LOOP

DELAY:  MOV R2, #20H
DELAY1: MOV R3, #0FFH
DELAY2: MOV R4, #0FFH

;DELAY:  MOV R2, #01H
;DELAY1: MOV R3, #01H
;DELAY2: MOV R4, #01H

DELAY3: DJNZ R4, DELAY3
	DJNZ R3, DELAY2
	DJNZ R2, DELAY1
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

; Increase Function
INCRESE:
	INC R1
	MOV A, R1
	SUBB A, #10
	JNZ SKIP
	MOV R1, #0
	RET
SKIP:
	RET

; Finish with an Infinite Loop
FINISH: JMP FINISH