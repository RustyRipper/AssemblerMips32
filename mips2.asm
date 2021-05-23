
# $t0 - wybór zamiaru
# $t2 - przesuniecie
# $t3 - pobraneSlowo
# $t4 - pobranyZnak
# $t5 - liczba 26
# $t7 - tymczasowa liczba do sprawdzenia czy nie nastapilo przesuniecie
.data
	
	
	

	powitanieMsg: .asciiz "Co chcesz zrobic szyfrowanie-0 odszyfrowywanie-1\n"
	zlyWyborMsg: .asciiz "\nzly wybor\n"
	podajWyrazMsg: .asciiz "\nPodaj wyraz:\n"
	podajPrzesuniecieMsg: .asciiz "\nPodaj Przesuniecie:\n"
	wynikMsg: .asciiz "\nWynik to:\n"
	
	pobraneSlowo: .space 17
.text

main:
	#wyswietlanie powitania
	li $v0,4
	la $a0,powitanieMsg
	syscall
	
	#pobieranie wyboru operacji do $t0
	li $v0, 5
	syscall
	move  $t0, $v0
	#sprawdzanie wyboru
	beq $t0,0,skip
	beq $t0,1, skip
	
	
	
	#wyswietlanie zlego wyboru
	li $v0,4
	la $a0,zlyWyborMsg
	syscall
	#powrot
	j main
	
skip:
	li $v0,4
	la $a0,podajWyrazMsg
	syscall
	
	#wczytywanie ³ancucha do $a0
	la $a0, pobraneSlowo
	li $a1,17
	li $v0, 8
	syscall
	#kopiowanie do rejestru $t3
	la $t3,pobraneSlowo
	
	#wiadomosc o przesunieciu
	li $v0,4
	la $a0,podajPrzesuniecieMsg
	syscall
	
	#wczytywanie przesuniecia
	li $v0, 5
	syscall
	move $t2, $v0
	
	#wiadomosc o wyniku
	li $v0,4
	la $a0 wynikMsg
	syscall
	
	beq $t0,0, szyfrowanie
	beq $t0,1, odszyfrowanie
	
szyfrowanie:	
	
	#wczytywanie pierwszego znaku
	lb $t4, ($t3)  	 
	#sprawdzanie czy koniec ci¹gu
 	beq $t4,10,exit 	 
 	beq $t4,0,exit 
 	#sprawdzanie spacji	
 	beq $t4,32,drukowanie

	# zmienna 26 bo tyle jest znakow
	li $t5,26  
	#dodanie w celu sprawdzenia czy nie bedzie wymagane dodanie 26
	add $t7,$t4,$t2
	blt $t7,65, cofniecie
	bgt $t7,90, doprzodu
	j skip2
	
cofniecie:
	add $t4, $t4, $t5
	j skip2
	
doprzodu:
	sub $t4, $t4, $t5
	
	skip2:
	
	#dodanie przesuniecia 				 				 				 				
 	add $t4, $t4, $t2
drukowanie: 	
	move $a0,$t4

	#drukowanie znaku
	li $v0,11 			
 	syscall
 	#zwiekszanie na nastepny znak
 	add $t3,$t3,1 			
 	
 	#zapetlenie				
 	j szyfrowanie
	
	
odszyfrowanie:
	
	
	#wczytywanie pierwszego znaku
	lb $t4, ($t3)  	 
	#sprawdzanie czy koniec ci¹gu
 	beq $t4,10,exit 	 	
 	beq $t4,0,exit 
 	#sprawdzanie spacji	
 	beq $t4,32,drukowanie2

	# zmienna 26 bo tyle jest znakow
	li $t5,26  
	#dodanie w celu sprawdzenia czy nie bedzie wymagane dodanie 26
	sub $t7,$t4,$t2
	blt $t7,65, cofniecie2
	bgt $t7,90, doprzodu2
	j skip3
	
cofniecie2:
	add $t4, $t4, $t5
	j skip3
doprzodu2:
	sub $t4, $t4, $t5
	
skip3:
	
	 				 				 				 				
 	#odjecie przesuniecia 
 	sub $t4, $t4, $t2
 	
drukowanie2: 
	move $a0,$t4

	#drukowanie znaku
	li $v0,11 			
 	syscall
 	#zwiekszanie na nastepny znak
 	add $t3,$t3,1 			
 	
 	#zapetlenie				
 	j odszyfrowanie
	
exit:
	li $v0, 10
	syscall
