.data
.align 2
strInfoBase: .asciiz "As bases possiveis para esse programa sao:\n2 - Binario\n8 - Octal\n10 - Decimal\n16 - Hexadecimal"
strGetBaseIn: .asciiz "Qual sera a base de entrada? "
strGetBaseOut: .asciiz "Qual sera a base de saida? "
strGetInput: 	.asciiz "Insira o numero: "
strOut1: .asciiz "O Numero "
strOut2: .asciiz " da base "
baseIn: .word 0
strOut3: .asciiz " para a base "
baseOut: .word 0
strOut4: .asciiz " eh "

input: .space 32
maxDigit: 	.word 0

.text

main:
# ----- Print Strings and Get Bases -----
	# Printing the possible bases to convert to
	li $v0, 4  		# 4 is the code for printing a string
	la $a0, strInfoBase 	# loading the string to be printed
	syscall			# requesting the system to print the message
	
	# Asking the user to enter baseIn
	li $v0, 4  		# 4 is the code for printing a string
	la $a0, strGetBaseIn 	# loading the string to be printed
	syscall			# requesting the system to print the ask message
	
	
	# Reading baseIn (int)
	li $v0, 5		# 5 is the code for reading a int
	syscall 		# requesting the system to read baseIn
	# Storing baseIn
	move $t1, $v0		# copying content in v0 to t1
	sw $t1, baseIn		# storing the value in the memory
	
	# Asking the user to enter baseOut
	li $v0, 4  		# 4 is the code for printing a string
	la $a0, strGetBaseOut 	# loading the string to be printed
	syscall			# requesting the system to print the ask message
	
	# Reading baseOut (int)
	li $v0, 5		# 5 is the code for reading a int
	syscall 		# requesting the system to read baseOut
	# Storing baseOut
	move $t1, $v0		# copying content in v0 to t1
	sw $t1, baseOut		# storing the value in the memory

# ----- Ask Number -----
	# Asking the user the number (input)
	li $v0, 4  		# 4 is the code for printing a string
	la $a0, strGetInput 	# loading the string to be printed
	syscall			# requesting the system to print the ask message

	la $s0, baseIn
 
	beq $s0, 2, set2
	beq $s0, 8, set8
	beq $s0, 10, set10
	beq $s0, 16, set16
       
set2:
	li $a1, 32
	j getstr
 
set8:
	li $a1, 16
	j getstr
 
set10:
	li $a1, 10
	j getstr
 
set16:
	li $a1, 8
       
getstr:
	li $v0, 8
	la $a0, input
	sw $a1, maxDigit
	syscall

# ----- Conversor de qualquer base para decimal ------
strToBase:
	la $t0, baseIn
	la $t1, maxDigit
	la $t2, input
	li $t9, 0	# Counter
	li $t8, 'a'	# coloque 'a' ou 'A'
	subi $t8, $t8, '0'	# Diferença entre '0' e 'a'
	li $s7, 0	# $s7 = Final Number
	# $t4 = digito convertido para int

strToBaseLoop:
	beq $t9, $t1, strToBaseLoopEnd
	mul $s7, $s7, $t0	# num = num*base
	
	lb $t4, ($t2)		# Pega caractere da string
	subi $t4, $t4, '0'	# Transforma Dígitos String para Int
	
	ble $t4, 9, notHex	# IF dígito Hexadecimal...
	sub $t4, $t4, $t8	# Tira a diferença entre '0' e 'a'
	addi $t4, $t4, 9	# Adiciona 9

notHex:
	add $s7, $s7, $t4	# num = num + $t4
	addi $t9, $t9, 1	# i++
	addi $t2, $t2, 1	# Avança na string
	j strToBaseLoop

strToBaseLoopEnd:

# ----- END of Conversor de qualquer base para decimal ------


