.data
.align 0
strInfoBase: .asciiz "As bases possiveis para esse programa sao:\n2 - Binario\n8 - Octal\n10 - Decimal\n16 - Hexadecimal"
strGetBaseIn: .asciiz "Qual será a base de entrada? "
strGetBaseOut: .asciiz "Qual será a base de saida? "
strOut1: .asciiz "O Numero "
strOut2: .asciiz " da base "
baseIn: .word 0
strOut2: .asciiz " para a base "
baseOut: .word 0
strOut2: .asciiz " eh "

binary: .word 0:31
input: .space 32

.text