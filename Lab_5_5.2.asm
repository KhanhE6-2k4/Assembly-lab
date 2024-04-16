.data
message1: .asciiz "Nhap xau can dao: "
message2: .asciiz "Xau ket qua: "
end_char: .byte '\n'
str: .space 100 
.text
li $v0, 4       # print "Nhap xau can dao: "
la $a0, message1
syscall
la $s1, str     # s1 -> address of str
addi $t2, $s1, 0
li $t0, 0       # i = 0
li $s0, 20      # max_lenght = 20
la $t1, end_char# t1 -> address of end_char
lb $t1, 0($t1)  # t1 = end_char
L1: li $v0, 12  # read str[i]
    syscall
    beq $t0, $s0, DONE_READ # if i >= 20 end_read
    beq $v0, $t1, DONE_READ # if str[i] = '\n' end_read
    sb $v0, 0($s1)       # str[i] = v0
    addi $s1, $s1, 1     # s1 -> address of str[i]
    addi $t0, $t0, 1     # i = i + 1
    j L1
DONE_READ: nop
li $v0, 4       # print "Xau ket qua: "
la $a0, message2
syscall
    
addi $s1, $s1, -1       # s1 -> address of str[lenght - 1] 
L2: lb $s2, 0($s1)      # s2 = str[i]
    li $v0, 11          # print str[i]
    addi $a0, $s2, 0
    syscall
    
    beq $s1, $t2, exit  # if str[i] = str[0] -> end print
    addi $s1, $s1, -1   # s1 _> address of str[i] 
    j L2
exit: nop

    
    

