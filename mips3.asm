# $t0 ilosc
# $t1 licznik ilosci ciagow
# $t2 licznik liczb
# $t3 wielkoscCiagu
# $t4 seed a pozniej znak

.data

	
	powitanieMsg: .asciiz "Podaj ile ciagow pseudolosowych\n"
	nowaLiniaMsg: .asciiz "\n"
	wielkoscCiagu: .word 10
	znak: .space 2
.text
	
main:

	#wyswietlanie zapytania
	li $v0,4
	la $a0,powitanieMsg
	syscall
	
	#pobieranie ilosci do $t0
	li $v0, 5
	syscall
	move  $t0, $v0
	
	#wielkoscCiagu do $t3
	lw $t3, wielkoscCiagu
	
	

generowanieCiagu:
	#wyswietlanie \n
	li $v0,4
	la $a0,nowaLiniaMsg
	syscall
	
	#zerowanie $t2
	move $t2, $zero
	
	#Warunek ilosci ciagow
	beq $t0, $t1, exit
	add $t1, $t1, 1
	
	#generowanie seeda losowego przy pomocy czasu
	li $v0, 30        
	syscall                  
	add $t4, $zero, $a0
	
	#liczenie reszty z dzielenia /42 zeby nie bylo bledu o braku pamieci
	div $t4, $t4 ,42
	mfhi $t4
	add $t4, $zero, $t4
	
generowanieLiczby:	

	#warunek ilosci liczb
	beq $t3, $t2, generowanieCiagu
	
	
	#algorytmy
	mul $t4, $t4 ,11
	add $t4, $t4 ,7
	#41 znaki wiec div42
	div $t4, $t4 ,42
	#reszta
	mfhi $t4
	
	#od 48 zaczynaja sie znaki
	add $t4, $t4, 48
	
     #zmiana na ascii
     sb $t4, znak
     la $a0, znak
     
     
	#wypisywanie   
     li $v0, 4
	syscall
     
	#inkrementacja
	add $t2, $t2, 1
	j generowanieLiczby
exit:
	li $v0, 10
	syscall

