ljmp start
org 8000h
	dane: db 15,14,13,12,11,10,09,08,07,06,05,04,03,02,01,00
	
org 0100h	

fswap:				;funkcja zamieniajaca miejscami liczby
	mov a, r0
	movx @dptr, a
	dec dpl			;zmniejszmy polowe mniejszej wagi dptr-a o 1
	mov a, r1
	movx @dptr, a
	inc dpl
	acall powrot
	
start: 
	mov dptr, #dane
	mov r7, #00h	;aktualny wskaznik pamieci xdata
	mov r6, dpl 	;r6 - dpl poczatkowy
ladowanie:			;ladujemy dane z code memory do xdata memory
	mov a, r7		
	movc a, @a+dptr
	mov b, a
	mov a, r7
	add a, dpl
	mov dpl, a
	mov a, b
	movx @dptr, a
	mov dpl, r6
	inc r7
	cjne r7, #010h, ladowanie
	
	mov r5, #00h 	;wskaznik tablicy zewnetrznej
druga:
	mov b, #00h 	;wskaznik na element tablicy wewnetrznej
pierwsza:
	;ladowanie dwoch liczb
	inc b
	movx a, @dptr	;pobieramy pierwsza liczbe do porownania - r0
	mov r0, a
	inc dptr		;zwiekszamy pointer na adres w xdata
	movx a, @dptr	;pobieramy druga liczbe do porownania - r1
	mov r1, a	
	;porownanie poprzez odjecie i sprawdzenie flagi przeniesienia
	mov a, r1
	clr c
	subb a, r0
	mov a,#00h
	jc fswap
powrot:
	mov a, b
	add a, r5		;optymalizacja algorytmu
	cjne a, #0fh, pierwsza
	mov dpl, r6
	inc r5
	cjne r5, #0fh, druga
	
	mov r5, #00h
	mov dpl, r6
wyswietl:
	inc r5
	movx a, @dptr
	inc dpl
	cjne r5, #010h, wyswietl
	
	
	nop
	nop
	nop
	jmp $ 
	end start
	