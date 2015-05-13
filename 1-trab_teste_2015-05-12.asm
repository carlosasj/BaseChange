.data
.align 2
strInfoBase: .asciiz "As bases possiveis para esse programa sao:\n2 - Binario\n8 - Octal\n10 - Decimal\n16 - Hexadecimal\n"
strGetBaseIn: .asciiz "Qual sera a base de entrada? "
strGetBaseOut: .asciiz "Qual sera a base de saida? "
strOut1: .asciiz "O Numero "
strOut2: .asciiz " da base "
baseIn: .word 15
strOut3: .asciiz " para a base "
baseOut: .word 0
strOut4: .asciiz " eh "

binary: .word 0:31
input: .space 32

.text

main:

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