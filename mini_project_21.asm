.data
arr: .space 2400
.text
li $v0, 5        # Get input number
syscall
addi $a1, $v0, 0 # a1 = input number
jal digit_Degree
exit: addi $a0, $v0, 0 # set a0 = result return from digit_Degree(a1) procedure
      li $v0, 1   
      syscall
      li $v0, 10
      syscall
end_main:
#-------------------------------------
digit_Degree:
sw $fp, -4($sp)  # store frame pointer
addi $fp, $sp, 0 # set fp = sp
addi $sp, $sp, -12 # adjust sp to get space
sw $ra, -8($sp)    # store return address
sw $a1, -12($sp)   # store a1
addi $t1, $0, 9   # set t1 = 9
slt $t0, $t1, $a1   # check if a1 > 9 (means a1 >= 10)
bne $t0, $0, L1 # if true then branch to L1
add $v0, $0, $0     # set v0 = 0
add $sp, $fp, $0    # restore sp
lw $fp, -4($sp)     # restore fp
jr $ra              # return
L1:
addi $t0, $0, 0     # set t0 = sum of digits = 0
L2: slt $t1, $0, $a1 # check if a1 > 0
    beq $t1, $0, end_L2 # if false then exit loop
    addi $t2, $0, 10    # set t2 = 10
    div $a1, $t2        # divide a1 by 10 (a1 = a1 / 10) 
    mflo $a1            # a1 = quotient
    mfhi $t3            # j = t3 = remainder
    add $t0, $t0, $t3    # sum = sum + t3 
    j L2                # jump to L2
end_L2: 
    add $a1, $0, $t0    # set a1 = sum 
    jal digit_Degree
recursion:
    lw $a1, -12($sp)    # restore a1
    lw $ra, -8($sp)     # restore return address
    add $sp, $fp, $0    # restore sp
    lw $fp, -4($sp)     # restore fp
    addi $v0, $v0, 1    # v0 = v0 + 1
    jr $ra              # return 
   
    

