.data
f1: .asciiz "The sum of "
f2: .asciiz " and "
f3: .asciiz " is "
.text
start:
addi $s0, $0, 5     # s0 = 5
addi $s1, $0, 10    # s1 = 10
li $v0, 4           # print "The sum of "
la $a0, f1
syscall
li $v0, 1           # print s0 (5)
add $a0, $0, $s0
syscall
li $v0, 4           # print " and "
la $a0, f2
syscall
li $v0, 1           # print s1 (10)
add $a0, $0, $s1
syscall
li $v0, 4           # print " is "
la $a0, f3
syscall
add $t0, $s0, $s1   # t0 = s0 + s1
li $v0, 1           # print t0
add $a0, $0, $t0
syscall
# Result: "The sum of (s0) and (s1) is (t0)"
