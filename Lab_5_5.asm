.data
string_input: .space 100
message1: .asciiz "Enter an string:"
message2: .asciiz "Lenght of string:"
.text
start:
li $v0, 8             # Get string 
la $a0, string_input
addi $a1, $0, 21
syscall               # execute
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
add $t0, $t0, -1     # t0 = lenght - 1, i = i - 1 (do this to skip '\n' in string)
addi $t4, $0, -1     # t4 = -1
# Print string with reverse order
L2: beq $t0, $t4, end_print   # Is i >= 0 

    add $t5, $t0, $s0 # address of string[i] in t5
    li $v0, 11        # serveice 11 is print character
    lb $a0, 0($t5)    # load string[i] to a0
    syscall           # execute
    addi $t0, $t0, -1 # i = i - 1
    j L2
end_print:
end:
     


 
