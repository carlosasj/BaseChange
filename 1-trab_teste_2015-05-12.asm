# Organização de Computadores - Trabalho 1: Base Converter
# ICMC - USP São Carlos
# 
# Turma 2
# Autores:
#	Carlos Alberto Schneider Júnior - 9167910
#	Lucas Kassouf Crocomo		- 8937420
#
.data
.align 2

strInfoBase: 	.asciiz "As bases possiveis para esse programa sao:\n2 - Binario\n8 - Octal\n10 - Decimal\n16 - Hexadecimal\n"
strGetBaseIn: 	.asciiz "Qual sera a base de entrada? "
strBaseInNotValid: .asciiz "Base de entrada não válida, insira outra...\n"
strGetBaseOut: 	.asciiz "Qual sera a base de saida? "
strBaseOutNotValid: .asciiz "Base de saída não válida, insira outra...\n"
strGetInput: 	.asciiz "Insira o numero: "
strOut: 	.asciiz "Numero na nova base: "
baseIn: 	.word 0
baseOut: 	.word 0

input: 		.space 32

.text

main:
# ----- Print Strings and Get Bases -----
	# Printing the possible bases to convert to
	li $v0, 4  		# 4 is the code for printing a string
	la $a0, strInfoBase 	# loading the string to be printed
	syscall			# requesting the system to print the message
	
askBaseIn:
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
	
	#-- Validate baseIn
	beq $t1, 2, askBaseOut	# case 2
	beq $t1, 8, askBaseOut	# case 8
	beq $t1, 10, askBaseOut	# case 10
	beq $t1, 16, askBaseOut	# case 16
	j baseInNotValid

baseInNotValid: 
	# Printing warning: base in not valid
	li $v0, 4  		# 4 is the code for printing a string
	la $a0, strBaseInNotValid 	# loading the string to be printed
	syscall			# requesting the system to print the message
	j askBaseIn

askBaseOut:
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
	
	#-- Validate baseOut
	beq $t1, 2, askNumber	# case 2
	beq $t1, 8, askNumber	# case 8
	beq $t1, 10, askNumber	# case 10
	beq $t1, 16, askNumber	# case 16
	j baseOutNotValid

baseOutNotValid: 
	# Printing warning: base out not valid
	li $v0, 4  		# 4 is the code for printing a string
	la $a0, strBaseOutNotValid 	# loading the string to be printed
	syscall			# requesting the system to print the message
	j askBaseOut

askNumber: 
# ----- Ask Number -----
	# Asking the user the number (input)
	li $v0, 4  		# 4 is the code for printing a string
	la $a0, strGetInput 	# loading the string to be printed
	syscall			# requesting the system to print the ask message

	# Set the max number of digits to read
	lw $s0, baseIn	# switch (baseIn)
 
	beq $s0, 2, set2	# case 2
	beq $s0, 8, set8	# case 8
	beq $s0, 10, set10	# case 10
	beq $s0, 16, set16	# case 16
       
set2:
	li $a1, 32	# in Binary, read 32 char (1111 1111 1111 1111 1111 1111 1111 1111)
	j getstr
 
set8:
	li $a1, 11	# in Octal, read 11 char (37 777 777 777)
	j getstr
 
set10:
	li $a1, 10	# in Decimal, read 10 char (4 294 967 295)
	j getstr
 
set16:
	li $a1, 8	# in Hexadecimal, read 8 char (FFFF FFFF)
       
getstr:	# Finally, read the number as string
	li $v0, 8	# Number of syscall to read a string
	la $a0, input	# Address to store the string
	syscall

	#-- Validate String

# ----- Convert any valid string to binary, in a register ------
strToBase:
	lw $t0, baseIn	# Load baseIn
	li $t1, '\n'	# Stopping criterion
	la $t2, input	# Load string input
	li $t8, 'a'		# put 'a' or 'A' to define if the hexadecimal will be uppercase (FFFF) or lowercase (ffff)
	subi $t8, $t8, '0'	# Gap between '0' and 'a'
	li $s7, 0	# $s7 = Final Number (num)
	# $t4 = Stores character converted to binary

strToBaseLoop:
	lb $t4, ($t2)		# Get Character of string
	beq $t4, $t1, strToBaseLoopEnd	# WHILE ($t4 != '\n') ...
	mul $s7, $s7, $t0	# num = num * base
	
	subi $t4, $t4, '0'	# Convert ASCII to number between [0..baseInt) (part 1)
	
	ble $t4, 9, notHex	# IF ($t4 <= 9) jump to "notHex"
	sub $t4, $t4, $t8	# ELSE subtract the gap between '0' and 'a' (or 'A') | At this point, the number is between 1 and 6
	addi $t4, $t4, 9	# Add 9 | so 'A' becomes 10; B becomes 11 ...

notHex:
	add $s7, $s7, $t4	# num = num + $t4
	addi $t2, $t2, 1	# Set next character on string
	j strToBaseLoop		# Back to Loop

strToBaseLoopEnd:

# ----- END of Convert any valid string to binary, in a register ------

	li $v0, 4  		# 4 is the code for printing a string
	la $a0, strOut 	# loading the string to be printed
	syscall			# requesting the system to print the message

	# Select the syscall (or function) to print the number
	lw $s0, baseOut	# switch (baseOut)
 
	beq $s0, 2, out2	# case 2
	beq $s0, 8, out8	# case 8
	beq $s0, 10, out10	# case 10
	beq $s0, 16, out16	# case 16

out2:
	li $v0, 35	# Print as Binary
	j printNumber
 
out8:
	j printOctal	# Print with the Octal Function
 
out10:
	li $v0, 36	# Print as Decimal
	j printNumber
 
out16:
	li $v0, 34	# Print as Hexadecimal


# ----- Print Number -----
printNumber:
	move $a0, $s7
	syscall
	j exit

# ----- Print Octal -----
printOctal:
	li $t0, 7	# Load Mask
	move $t8, $sp	# Save Stack Pointer
	beq $s7, $zero, printZero	# IF (num == 0) printZero

printOctalLoop:
	beq $s7, $zero, printOctalLoopEnd	# IF (num == 0) printOctalLoopEnd
	and $t2, $t0, $s7	# Apply the mask
	addi $sp, $sp, -4	# Decrease the Stack Pointer
	sw $t2, ($sp)		# Store the masked number on Stack
	srl $s7, $s7, 3		# Shift num 3 bits to right
	j printOctalLoop	# Back to loop
	
printOctalLoopEnd:
	beq $sp, $t8, exit	# IF ($sp == ($sp_before_printOctal)) exit
	lw $a0, ($sp)		# Load $sp to print
	li $v0, 1			# Set the syscall
	syscall				# print
	addi $sp, $sp, 4	# Increase Stack Pointer
	j printOctalLoopEnd	# Back to loop
	
# ----- Print Zero -----
printZero:
	li $v0, 1
	li $a0, 0
	syscall

# ----- Exit -----
exit:
	li $v0, 10
	syscall 
