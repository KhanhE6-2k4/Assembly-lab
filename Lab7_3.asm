.text
input: addi $s0, $0, 2   # set s0 = 2
       addi $s1, $0, 5   # set s1 = 5
push:  addi $sp, $sp, -8 # adjust stack pointer
       sw $s0, 4($sp)    # push s0 in stack
       sw $s1, 0($sp)    # push s1 in stack
work:  nop
       nop
pop:   lw $s0, 0($sp)    # pop from stack to s0
       lw $s1, 4($sp)    # pop from stack to s1       
       addi $sp, $sp, 8  # adjust stack pointer
      