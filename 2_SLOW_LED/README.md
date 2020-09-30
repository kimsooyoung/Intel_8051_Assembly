## Slow Led

Same with first program, but there's some differences in `delay` section.

```
DELAY: 	MOV R0, #01FH
DELAY1:	MOV R1, #0FFH
DELAY2: MOV R2, #0FFH

; SAME WITH PREV EXAMPLE, BUT ANOTHER DELAY ADDED
DELAY3: DJNZ R2, DELAY3
	DJNZ R1, DELAY2
	DJNZ R0, DELAY1
	RET
```