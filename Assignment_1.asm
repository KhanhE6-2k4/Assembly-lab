# condition : $s1 xor $s2 < 0
# if (condition is false) -> No Overflow  
# else if ($s1 < 0) (if ($s3 < $s1) -> No Overflow else -> Overflow) 
#      else (if ($3 > $s1) -> No Overflow else -> Overflow) (L1)
.text
start:
addi $s1, $0, 0x7ffffffe   # Load 0x7ffffffe to $s1
addi $s2, $s0, 0x1         # Load 0x1 to $s1
addi $t0, $0, 0            # Set default status is No Overflow
addu $s3, $s1, $s2         # s3 = s1 + s2
xor $t1, $s1, $s2          # Test if $s1 and $s2 have the same sign
bltz $t1, No_Overflow      # if not, No Overflow

slt $t2, $s3, $s1          # set t2 = 1 if (t3 < s1) else t2 = 0
bltz $s1, L1               # branch to L1 if ($s1  < 0)
beq $t2, 0, No_Overflow    # when $s1 and $s2 are not negative
                           # if (s3 >= s1) No Overflow 
                           # else Overflow
j Overflow


L1: # if ($s3 < $s1) -> No Overflow  ($s1, $s2 are negative)
    # else -> Overflow
  
    bne $t2, $0, No_Overflow   # if (s3 < s1) No Overflow
                               # else OverFlow
    j Overflow


No_Overflow: j exit

Overflow: addi $t0, $0, 1      # Set current status is Overflow

exit:
