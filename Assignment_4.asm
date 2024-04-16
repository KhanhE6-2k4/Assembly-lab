.text
start:
addi $s1, $0, 0x7ffffffe   # Load 0x7ffffffe to $s1
addi $s2, $s0, 0x1         # Load 0x1 to $s1
addi $t0, $0, 0 # Set default status is No Overflow
addu $s3, $s1, $s2 # $s3 = $s1 + $s2
xor $t1, $s1, $s2 # Test if $s1 and $s2 have the same sign
bltz $t1, No_Overflow # if not, no Overflow
                      # if have
xor $t2, $s3, $s1     # Test if $s1 and $s3 have the same sign
bgez $t2, No_Overflow # if have, no Overflow
 
Overflow: addi $t0, $0, 1 # Overflow => Set $t0 = 1
          j exit

No_Overflow:
exit:
