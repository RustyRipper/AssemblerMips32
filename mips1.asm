.data
	idx_dodawanie: .word 0
	idx_odejmowanie: .word 1
	idx_mnozenie: .word 2
	idx_dzielenie: .word 3
	napis1: .asciiz "Podaj pierwsza liczbe\n"
	napis2: .asciiz "Podaj operacje\n 0.Dodawanie \n 1.Odejmowanie \n 2.Mnozenie \n 3.Dzielenie\n"
	napis3: .asciiz "Podaj druga liczbe\n"
	napis4: .asciiz "Wynik to: \n"
	napis5: .asciiz "\nJesli chcesz powtorzyc wprowadz 1, jesli nie to cos innego np 0\n"
	napis6: .asciiz "\nZly kod operacji\n"
	napis7: .asciiz "\nReszta: \n"
	
.text
main:
	lw $t4, idx_dodawanie
	lw $t5, idx_odejmowanie
	lw $t6, idx_mnozenie
	lw $t7, idx_dzielenie

	algorytm:
	li $v0,4
	la $a0, napis1
	syscall

	li $v0, 5
	syscall
	move  $t0, $v0
	
	operacja:
	li $v0,4
	la $a0, napis2
	syscall
	
	li $v0, 5
	syscall
	move  $t1, $v0
	
	bgt $t1, $t7, komunikat
	blt $t1, $t4, komunikat
	
	drugaliczba:
	li $v0,4
	la $a0, napis3
	syscall
	
	li $v0, 5
	syscall
	move  $t2, $v0
	
	
	
	 beq $t1, $t4, dodawanie
	 beq $t1, $t5, odejmowanie
	 beq $t1, $t6, mnozenie
	 beq $t1, $t7, dzielenie
	 
	komunikat:
	li $v0,4
	la $a0, napis6
	syscall
	
	j operacja
	
	
	
	dodawanie:
	add $t3, $t0, $t2
	j skip
	
	odejmowanie:
	
	sub $t3, $t0, $t2
	j skip
	
	mnozenie:
	mul $t3, $t0, $t2
	j skip
	
	dzielenie:
	beq $t2, $zero, drugaliczba
	div $t3, $t0, $t2
	
	
	
	j skip
	
	skip:
	li $v0,4
	la $a0, napis4
	syscall
	
	li $v0, 1
	add $a0, $zero, $t3
	syscall
	
         bne $t1, $t7,wynik
	li $v0,4
	la $a0, napis7
	syscall
	
	li $v0, 1
	mfhi $t3
	add $a0, $zero, $t3
	syscall

	wynik:
	li $v0,4
	la $a0, napis5
	syscall

	li $v0, 5
	syscall
	move  $t0, $v0
	
 	beq $t5, $t0, algorytm
	
	li $v0, 10
	syscall
