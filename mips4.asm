# $t0 wybor liczba/operacja
# $t1 wybor operacji
# $t2 liczba do zapisania na stosie
# $t3 ilosc elem na stosie
# $t4 liczba pobranna ze stosu
# $t5 druga liczba ze stosu potrzebna do wykonania operacji / inkrementacja do wyswietlania
# $t6 inkrementacja do przygotowywania
# $t7 wartosc 3

.data

	powitanieMsg: .asciiz "\nPodaj czy liczba/operacja/exit 0/1/2\n"
	operacjaMsg: .asciiz "0 dodawanie, 1 odejmowanie, 2 mnozenie, 3 dzielenie\n"
	liczbaMsg: .asciiz "Podaj liczbe\n"
	stosMsg: .asciiz "Stos: "
	nowaLiniaMsg: .asciiz "\n"
	spacjaMsg: .asciiz " "
	
.text

main:
	
	#wyswietlanie zapytania
	li $v0,4
	la $a0,powitanieMsg
	syscall
	
	#pobieranie wyboru do $t0
	li $v0, 5
	syscall
	move  $t0, $v0
	
	#sprawdzanie
	beq $zero, $t0, skip

	# 2- exit
	add $t2, $zero, 2
	beq $t2, $t0, exit
	#sprawdzanie czy mozna wykonac operacje
	blt $t3 ,$t2, main
	
	#wyswietlanie zapytania o operacji
	li $v0,4
	la $a0,operacjaMsg
	syscall
	
	#pobieranie wyboru do $t1
	li $v0, 5
	syscall
	move  $t1, $v0
	
	#sprawdzanie czy dzielenie
	add $t7, $zero, 3
	beq $t1, $t7, dzielenieZero
	
	#sciaganie wdwoch wartosci
	jal pop
	wczytywanie:
	move $t5, $t4
	jal pop
	
	beq $t1 , 0, dodawanie 
	beq $t1 , 1, odejmowanie
	beq $t1 , 2, mnozenie
	beq $t1 , 3, dzielenie 
	
	dodawanie:
	add $t2, $t4, $t5
	j push
	
	odejmowanie:
	sub $t2, $t4, $t5
	j push
	
	mnozenie:
	mul $t2, $t4, $t5
	j push
	
	dzielenie:
	div $t2, $t4, $t5
	j push
	
	dzielenieZero:
	
	jal pop
	move $t2, $t4
	beq $t2, $zero,push
	j wczytywanie
	
	skip:
	
	#wyswietlanie zapytania o liczbe
	li $v0,4
	la $a0,liczbaMsg
	syscall
	
	#pobieranie wyboru do $t2
	li $v0, 5
	syscall
	move  $t2, $v0
	
	push:
	addi $sp, $sp, -4 # Obni¿ SP o s³owo
	sw $t2, 0($sp) # Zapisz $t2 na stosie
	add $t3, $t3, 1 # inkrementacja
	
	
	#wyswietlanie stos:
	li $v0,4
	la $a0,stosMsg
	syscall
	
	move $t5, $t3 
	move $t6, $t3 
	
	przygotowanie:
	#ustawianie wskaznika na element na samym dole
	beq $t6, 0, wyswietlStos
	addi $sp, $sp, 4
	sub $t6, $t6, 1
	j przygotowanie
	
	
	pop: 
	lw $t4, 0($sp) # Za³aduj wartoœæ do $t4
	addi $sp, $sp, 4 # obniz SP o s³owo
	sub $t3, $t3, 1 #deinkrementacja
	jr $ra
	
	wyswietlStos:
	beq $t5, 0, main 
	subi $sp, $sp, 4 # Zwiêksz SP o s³owo
	lw $t4, 0($sp) # Za³aduj wartoœæ do $t4
	
	
	#wyswietlanie
	li $v0, 1
	add $a0, $zero, $t4
	syscall
	
	#wyswietlanie spacji
	li $v0,4
	la $a0,spacjaMsg
	syscall
	
	#deinkrementacja
	sub $t5, $t5, 1
	j wyswietlStos
	
	exit:
	li $v0, 10
	syscall
