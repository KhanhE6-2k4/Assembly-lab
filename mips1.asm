.data
x: .word 14
y: .word 1
.text 
la $t0, x
lw $s0, 0($t0)
addi $s0, $s0, 10
sw $s0, 0($t0)
la $t1, y
lw $s1, 0($t1)
sll $s1, $s1, 3 # $s1 = $s1 * 8
sw $s1, 0($t1)