.data
A: .word 7, -2, 5, 1, 5, 6, 7, 3, 6, 8, 8, 59, 5
Aend: .word
char: .byte ' '
.text
main:
# lenght of array = n = 13
la $a0, A     # ao = address of A[0]
li $a1, 13    # n = 13
addi $a2, $a1, -1 # a2 = n - 1
li $t0, 0         # i = 0
LOOP_i: slt $t1, $t0, $a2  # check if (i < n - 1)
        beq $t1, $0, exit_LOOP_i # if  not then exit lOOP_i
        li $t1, 0   # swapped = t1 = 0
        li $t2, 0   # j = 0
        sub $a3, $a2, $t0  # a3 = n - 1 - i
        LOOP_j: slt $t3, $t2, $a3 # check if (j < n - 1 - i)
                beq $t3, $0, exit_LOOP_j # if not then exit LOOP_j
                sll $t5, $t2, 2   # t5 = 4 * j
                add $s1, $a0, $t5 # s1 = address of A[j]
                addi $s2, $s1, 4  # s2 = address of A[j + 1]
                lw $s3, 0($s1)    # s3 = A[j]
                lw $s4, 0($s2)    # s4 = A[j + 1]
                slt $t4, $s4, $s3 # check if A[j + 1] < A[j]
                beq $t4, $0, continue # if not dont do anything
                li $t1, 1         # swapped = 1
                sw $s3, 0($s2)    # A[j + 1] = s3 = A[j]
                sw $s4, 0($s1)     # A[j] = s4 = A[j + 1]
                continue:
                addi $t2, $t2, 1   # j = j + 1
                j LOOP_j
        exit_LOOP_j:
        beq $t1, $0, exit_LOOP_i # if (swapped = 0) exit LOOP
        addi $t0, $t0, 1         # i = i + 1
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


