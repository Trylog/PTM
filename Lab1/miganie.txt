ljmp start
org 0100h
	delay:	mov r0, #0FFH		; opóznienie do mrugania
	one:	mov r1, #0FAH
	dwa:	djnz r1, dwa
		djnz r0, one
		ret
	start:
	mov p1, #01111111b
	lcall delay
	mov p1, #10111111b
	lcall delay
	mov p1, #11011111b
	lcall delay
	mov p1, #11101111b
	lcall delay
	mov p1, #11110111b
	lcall delay
	mov p1, #11111011b
	lcall delay
	mov p1, #11111101b
	lcall delay
	mov p1, #11111110b
	lcall delay
	lcall start
	END