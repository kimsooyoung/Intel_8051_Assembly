;***********************************
; LCD address on the 8051 board

LCDWIR          EQU 0FFE0H; LCD IR Write
LCDWDR          EQU 0FFE1H; LCD DR Wrtie
LCDRIR          EQU 0FFE2H; LCD IR Read
LCDRDR          EQU 0FFE3H; LCD DR Read

; DEFINE VARIABLES
;***********************************

INST            EQU 20H; LCD INSTRUCTION value storage
DATA            EQU 21H; LCD DATA value storage
LROW            EQU 22H; LCD display coordinate: value of column storage
LCOL            EQU 23H; LCD display coordinate: value of row storage
MESSAGE_LEN     EQU 24H; Message Length
FDPL            EQU 25H; DPL value storage
FDPH            EQU 26H; DPH value storage

; DEFINE LCD INSTRUCTION
;***********************************
CLEAR           EQU 01H; CLEAR command
;Cursor home
CUR_HOME        EQU 02H; CURSOR Home position move
; Cursor direction of progress control
ENTRY2          EQU 06H; Address +1, cursor or blink shift right, display x
; Display On/Off control
DCB6            EQU 0EH; Display On, Cursor On, Blink Off
;Function setting
FUN5            EQU 38H; 8bit 2 column 5*7

; DDRAM Address setting
LINE_1          EQU 080H; move LCD 1 line
LINE_2          EQU 0C0H; move LCD 2 line

; initialize the LCD
LCD_INIT:
    MOV INST, #FUN5
    CALL WRITE_INST

    MOV INST, #DCB6
    CALL WRITE_INST

    MOV INST, #CLEAR
    CALL WRITE_INST

    MOV INST, #ENTRY2
    CALL WRITE_INST

; Display message on the LCD
LCD_MSG:  
    MOV LROW, #01H
    MOV LCOL, #02H
    CALL MOV_CURSOR

    MOV DPTR, #MESSGAE1
    MOV FDPL, DPL
    MOV FDPH, DPH
    MOV MESSAGE_LEN, #0EH
    CALL DISPLAY_MESSAGE

    MOV LROW, #02H
    MOV LCOL, #02H
    CALL MOV_CURSOR

    MOV DPTR, #MESSAGE2
    MOV FDPL, DPL
    MOV FDPH, DPH
    MOV MESSAGE_LEN, #0EH
    CALL DISPLAY_MESSAGE
    JMP $

;***********************************
;***********************************

DISPLAY_MESSAGE:
    MOV R5, #00H
FLOOP:
    MOV DPL, FDPL
    MOV DPH, FDPH
    MOV A, R5
    MOVC A, @A+DPTR
    MOV DATA, A
    CALL WRITE_INST
    INC R5
    MOV A, R5
    CJNE A, MESSAGE_LEN, FLOOP
    RET

;***********************************
;***********************************

MOV_CURSOR:
    MOV A, LROW
    CJNE A, #01H, ROW_2
ROW_1:
    MOV A, #LINE_1
    ADD A, LCOL
    MOV INST, A
    CALL WRITE_INST
    JMP RET_POINT
ROW_2:
    CJNE A, #02H, RET_POINT
    MOV A, #LINE_2
    ADD A, LCOL
    MOV INST, A
    CALL WRITE_INST
RET_POINT:
    RET

;***********************************
;***********************************

WRITE_INST:
    CALL WAIT_UNTIL_READY
    MOV DPTR, #LCDWIR
    MOV A, INST
    MOVX @DPTR, A
    RET

;***********************************
;***********************************

WRITE_DATA:
    CALL WAIT_UNTIL_READY
    MOV DPTR, #LCDWDR
    MOV A, DATA
    MOVX @DPTR, A
    RET

;***********************************
;***********************************

WAIT_UNTIL_READY:
    MOV DPTR, #LCDRIR
    MOVX A, @DPTR
    JB ACC.7, WAIT_UNTIL_READY
    RET

MESSGAE1:
    DB 'D','O','','Y','O'
    DB 'U','R','','B','E'
    DB 'S','T','','!'
MESSAGE2:
    DB 'Y','O','U','','C'
    DB 'A','N','','D','O'
    DB '','I','T','!'
END