.data
string_input: .space 100
message1: .asciiz "Enter string:"
message2: .asciiz "Lenght of string:"
.text
li $v0, 54            # Get string with a message dialog
la $a0, message1
la $a1, string_input
addi $a2, $0, 100
syscall
la $s0, string_input  # address of string in s0
add $t0, $0, $0       # i = 0
L1: 
add $t1, $t0, $s0     # address of string[i] in t1
lb $t1, 0($t1)        # t1 = string[i]
beq $t1, $0, end_get_lenght  # Is null char ?
addi $t0, $t0, 1      # i = i + 1
j L1
end_get_lenght:
# length of string in t0
li $v0, 56            # show lenght of string to a message dialog
la $a0, message2
addi $a1, $t0, -1     # skip '\n' at the end of string
syscall

 
