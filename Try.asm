.text
addi $t1, $0, 18
addi $s2, $0, 0
LOOP: slt $t2, $zero, $t1
bne $t2, $zero, ELSE
j DONE
ELSE: addi $s2, $s2, 2
addi $t1, $t1, -1
j LOOP
DONE: