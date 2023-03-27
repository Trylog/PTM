ljmp start
org 0100h

	start:
	;dodawanie
	mov P1, #00h	;wyzerowanie diod
	mov a, #01h		;wczytanie pierwszej liczby do akumulatora
	mov r0, #02h	;wczytanie drugiej liczby do rejestru 
	add a, r0 		;wykonanie dodawania
	clr c 			;wyczyszcenie flagi przeniesienia (carry)
	xrl a, #0ffh	;zamiana zer na jedynki (0 - dioda zapalona)
	mov P1, a		;przeniesienie wyniku dodawania do rejestru diod
	
	;wyzerowanie diod
	mov P1, #00h
	
	;odejmowanie
	mov a, #05h 
	mov r1, #0ah 
	subb a, r1 		;wykonanie odejmowania, operacja subb uwzglednia "pozyczke" z flagi c, dlatego ja wyzej czyscimy
	xrl a, #0ffh
	mov P1, a
	
	;wyzerowanie diod
	mov P1, #00h
	
	;mnozenie
	mov a, #05h
	mov b, #04h		;wczytanie drugiej liczby do rejestru pomocniczego
	mul ab			;wykonanie mnozenia -> wynik zajmuje 16 bitow wiec trafia do obu rejestrow wejsciowych
	xrl a, #0ffh
	mov P1, a
	xrl b, #0ffh
	mov P1, b
	
	;wyzerowanie diod
	mov P1, #00h
	
	;dzielenie
	mov a, #0fh 
	mov b, #03h
	div ab 			;wykonanie dzielenia -> wynik trafia do akumulatora, a reszta do rejestru pomocniczego
	xrl a, #0ffh
	mov P1, a
	xrl b, #0ffh
	mov P1, b
	
	;wyzerowanie diod
	mov P1, #00h
	
	;dodawanie dwoch liczb 16-bitowych (o szerokosci dwoch rejestrow)
	mov r0, #01h	;/*
	mov r1, #02h	;	wczytanie danych do rejestrow
	mov r2, #03h	;   zapis liczb: pierwsza: r0, r1, druga: r2, r3
	mov r3, #04h	;*/
	
	mov a, r1		;przeniesienie zawartosci rejestru r1 - do akumulatora
	add a, r3		;dodawanie bitow nizszej wagi
	mov r4, a
	mov a, r0
	addc a, r2		;dodawanie bitow wyzszej wagi z uwzglednieniem przeniesienia
	mov b, r4
	xrl a, #0ffh
	mov P1, a		;wyswietlamy wynik od najbardziej znaczacego bitu 
	xrl b, #0ffh
	mov P1, b

	nop
	nop
	jmp $
	END start