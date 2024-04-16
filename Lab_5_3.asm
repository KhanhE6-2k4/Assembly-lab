.data
x: .space 100      # destination string x, empty
y: .space 100      # source string y
message: .asciiz "Nhap xau y:"
.text
addi $v0, $0, 54
la $a0, message    # load address of message
la $a1, y          # load the address of y to a1
addi $a2, $0, 100  # maximum number of characters to read in a2
syscall
la $s0, x          # load the address of x to s0
la $s1, y          # load the address of y to s1
strcpy:
add $t0, $0, $0    # t0 = i = 0
L1: 
add $t1, $s1, $t0  # t1 -> address of y[i]
lb $t1, 0($t1)     # t1 = y[i]
add $t2, $s0, $t0  # t2 -> address of x[i]
sb $t1, 0($t2)     # x[i] = y[i]
beq $t1, $0, end_strcpy
nop
addi $t0, $t0, 1    # i = i + 1
j L1
end_strcpy: nop







