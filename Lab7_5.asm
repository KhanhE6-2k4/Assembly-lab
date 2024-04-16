.data
mes1: .asciiz "Largest: "
mes2: .asciiz " Smallest: "

.text
main:
addi $s0, $0, 2   # s0 = 2
addi $s1, $0, 1   # s1 = 1
addi $s2, $0, -3  # s2 = -3
addi $s3, $0, 4   # s3 = 4
addi $s4, $0, 0   # s4 - 0
addi $s5, $0, 7   # s5 = 7
addi $s6, $0, 9   # s6 = 9
addi $s7, $0, 4   # s7 = 4
jal proc_max
addi $t0, $v0, 0  # t0 = largest
addi $t1, $v1, 0  # t1 = largest position
print_max:  # Print the largest element and the positon of this element in 8 registers
       addi $v0, $0, 4 
       la $a0, mes1
       syscall
       addi $v0, $0, 1
       addi $a0, $t0, 0
       syscall
       addi $v0, $0, 11
       addi $a0, $0, 44
       syscall
       addi $v0, $0, 1
       addi $a0, $t1, 0
       syscall
       
jal proc_min # Print the smallest element and the positon of this element in 8 registers
addi $t2, $v0, 0  # t2 = smallest
addi $t3, $v1, 0  # t3 = smallest position

print_min:  
       addi $v0, $0, 4 
       la $a0, mes2
       syscall
       addi $v0, $0, 1
       addi $a0, $t2, 0
       syscall
       addi $v0, $0, 11
       addi $a0, $0, 44
       syscall
       addi $v0, $0, 1
       addi $a0, $t3, 0
       syscall
       
exit:  addi $v0, $0, 10
       syscall
end_main:
#----------------------------------------------
proc_max: # The procedure to find the largest element and the position of this element
sw $fp, -4($sp)   # store frame pointer
addi $fp, $sp, 0  # fp = sp
addi $sp, $sp, -40 # allocate space in stack
sw $ra, 32($sp)    # store return address
sw $s7, 28($sp)    # sotore s7
sw $s6, 24($sp)    # store s6
sw $s5, 20($sp)    # store s5
sw $s4, 16($sp)    # store s4
sw $s3, 12($sp)    # store s3
sw $s2, 8($sp)     # store s2
sw $s1, 4($sp)     # store s1
sw $s0, 0($sp)     # store s0
add $v0, $s0, $0   # set max = s0
addi $v1, $0, 0    # set max_pos = 0
addi $t0, $0, 1    # i = 0
addi $t1, $0, 8    # t1 = n = 8 (8 registers)
LOOP1: slt $t2, $t0, $t1     # check if i < 8
     beq $t2, $0, end_LOOP1 # if not then end loop
     sll $t2, $t0, 2       # t2 = 4 * i
     add $t2, $sp, $t2     # t2 = sp[i]
     lw $t2, 0($t2)        # t2 = si (i in [0, 7])
     slt $t3, $v0, $t2     # check if si > max
     beq $t3, $0, continue1 # if false then skip
     add $v0, $t2, $0      # if true then set max = si
     add $v1, $t0, $0      # and set max_pos = i (which mean largest element is stored in $si)
     continue1:
     addi $t0, $t0, 1      # i = i + 1
     j LOOP1
end_LOOP1:
lw $s0, 0($sp)      # restore s0
lw $s1, 4($sp)      # restore s1
lw $s2, 8($sp)      # restore s2
lw $s3, 12($sp)     # restore s3
lw $s4, 16($sp)     # restore s4
lw $s5, 20($sp)     # restore s5
lw $s6, 24($sp)     # restore s6
lw $s7, 28($sp)     # restore 27
lw $ra, 32($sp)     # restore return address
addi $sp, $fp, 0    # restore sp
lw $fp, -4($sp)     # restore fp
jr $ra              # return
proc_min: # The procedure to find the smallest element and the position of this element
sw $fp, -4($sp)   # store frame pointer
addi $fp, $sp, 0  # fp = sp
addi $sp, $sp, -40 # allocate space in stack
sw $ra, 32($sp)    # store return address
sw $s7, 28($sp)    # sotore s7
sw $s6, 24($sp)    # store s6
sw $s5, 20($sp)    # store s5
sw $s4, 16($sp)    # store s4
sw $s3, 12($sp)    # store s3
sw $s2, 8($sp)     # store s2
sw $s1, 4($sp)     # store s1
sw $s0, 0($sp)     # store s0
add $v0, $s0, $0   # set min = s0
addi $v1, $0, 0    # set min_pos = 0
addi $t0, $0, 1    # i = 0
addi $t1, $0, 8    # t1 = n = 8 (8 registers)
LOOP2: slt $t2, $t0, $t1     # check if i < 8
     beq $t2, $0, end_LOOP2 # if not then end loop
     sll $t2, $t0, 2       # t2 = 4 * i
     add $t2, $sp, $t2     # t2 = sp[i]
     lw $t2, 0($t2)        # t2 = si (i in [0, 7])
     slt $t3, $t2, $v0     # check if si < min
     beq $t3, $0, continue2 # if false then skip
     add $v0, $t2, $0      # if true then set min = si
     add $v1, $t0, $0      # and set min_pos = i (which mean smallest element is stored in $si)
     continue2:
     addi $t0, $t0, 1      # i = i + 1
     j LOOP2
end_LOOP2:
lw $s0, 0($sp)      # restore s0
lw $s1, 4($sp)      # restore s1
lw $s2, 8($sp)      # restore s2
lw $s3, 12($sp)     # restore s3
lw $s4, 16($sp)     # restore s4
lw $s5, 20($sp)     # restore s5
lw $s6, 24($sp)     # restore s6
lw $s7, 28($sp)     # restore 27
lw $ra, 32($sp)     # restore return address
addi $sp, $fp, 0    # restore sp
lw $fp, -4($sp)     # restore fp
jr $ra              # return


     
