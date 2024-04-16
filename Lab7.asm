.data
mes1: .asciiz "Ket qua tinh giai thua la: "
.text
main:
li $a0, 10       # n = 10
jal factorial
add $t0, $v0, $0 # set t0 = v0 = n!
print:    addi $v0, $0, 56
          la $a0, mes1
          add $a1, $t0, $0  # a0 = n!
          syscall
end_main: li $v0, 10
          syscall           # terminate
#----------------------------------------------------
addi $t0, $0, 1     # t0 = 1

factorial: 
sw $fp, -4($sp)    # store frame pointer
add $fp, $sp, $0   # fp = sp
addi $sp, $sp, -12 # adjust the stack pointer (4 space)
sw $ra, -8($fp)    # store return address
sw $a0, -12($fp)   # store a0
blt $t0, $a0, L1   # if (n > 1) then branch to L1
addi $v0, $0, 1    # else v0 = 1
addi $sp, $fp, 0   # restore sp
lw $fp, -4($sp)    # restore fp
jr $ra             # return 
L1: addi $a0, $a0, -1 # n = n - 1
    jal factorial     # call recursion
do: lw $a0, -12($fp)  # restore n
    lw $ra, -8($fp)   # restore return address (address of next command)
    addi $sp, $fp, 0  # restore sp
    lw $fp, -4($sp)   # restore fp
    mul $v0, $v0, $a0 # v0 = v0 * n
    jr $ra
  



