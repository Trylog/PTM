ljmp start
org 0100h 
	delay:	mov r0, #0FFH		; opóznienie do mrugania
	one:	mov r1, #0AH
	dwa:	djnz r1, dwa
		djnz r0, one
		ret
	start:
	cpl p3.2
	lcall delay
	lcall start
	END