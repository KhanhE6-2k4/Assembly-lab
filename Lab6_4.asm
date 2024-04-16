.data
A: .word 7, -2, 5, 1, 5, 6, 7, 3, 6, 8, 8, 59, 5
Aend: .word
char: .byte ' '
.text
main:
# lenght of array = n = 13
la $a0, A     # ao = address of A[0]
addi $t4, $a0, 4 # t4 = address of A[1]
li $a1, 13    # n = 13

li $t0, 1         # i = 1
LOOP_i: slt $t1, $t0, $a1  # check if (i < n)
        beq $t1, $0, exit_LOOP_i # if  not then exit lOOP_i
        lw $t5, 0($t4)  # t5 = A[i]
        addi $t2, $t0, 0   # j = i

        
        LOOP_j: addi $a3, $t2, -1 # a3 = j - 1
                sll $a3, $a3, 2      # a3 = 4 *(j - 1) 
                add $a3, $a0, $a3    # a3 = address of A[j - 1]
                lw $a3, 0($a3)       # a3 = A[j - 1]
                slt $t3, $t5, $a3 # check if a[j - 1] > value
                beq $t3, $0, exit_LOOP_j # if not then exit LOOP_j
                slt $t3, $0, $t2          # check if j > 0
                beq $t3, $0, exit_LOOP_j
                sll $t3, $t2, 2   # t3 = 4 * j
                add $a2, $a0, $t3 # a2 = address of A[j]
                sw $a3, 0($a2) # A[j] = a3 = A[j - 1]
                addi $t2, $t2, -1   # j = j - 1
                j LOOP_j
        exit_LOOP_j:
        sll $t3, $t2, 2   # t3 = 4 * j
        add $a2, $a0, $t3 # a2 = address of A[j]
        sw $t5, 0($a2)    # A[j] = value
        addi $t0, $t0, 1   # i = i + 1
        addi $t4, $t4, 4   # t4 = t4 + 4 
        j LOOP_i
exit_LOOP_i:
# print sorted array

add $t4, $a0, $0   # t5 = address of A[0]
li $t0, 0          # i = 0
LOOP:

slt $t1, $t0, $a1  # check if (i < n)
beq $t1, $0, end_main
li $v0, 1 
lw $a0, 0($t4)
syscall 
li $v0, 11
la $t1, char
lw $a0, 0($t1)
syscall
addi $t4, $t4, 4
addi $t0, $t0, 1
j LOOP
end_main:
