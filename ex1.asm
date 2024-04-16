# condition : $s1 xor $s2 < 0
# if (condition is false) -> No Overflow  
# else if ($s1 < 0) (if ($s3 < $s1) -> No Overflow else -> Overflow) 
#      else (if ($3 > $s1) -> No Overflow else -> Overflow)
.text
start:
addi $t0, $0, 0
addu $s3, $s1, $s2
xor $t1, $s1, $s2
slti $t2, $t1, 0
beq $t2, $0, No_Overflow
slti $t2, $s1, 0
bne $t2, $0, L1
slt $t2, $s1, $s3
bne $t2, $0, No_Overflow
j Overflow

L1: # if ($s3 < $s1) -> No Overflow  
    # else -> Overflow
    slt $t2, $s3, $s1
    bne $t2, $0, No_Overflow
    j Overflow


No_Overflow: j exit

Overflow: addi $t0, $0, 1

exit:
 