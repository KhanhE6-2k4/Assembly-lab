.data
mes1: .asciiz "The largest element: "
.text
main:  li $a0, 1  # load test input
       li $a1, -4 
       li $a2, 3  
       jal max
       nop
       addi $t0, $v0, 0    # set t0 = max
print: li $v0, 56 
       la $a0, mes1
       add $a1, $t0, $0
       syscall
       li $v0, 10
       syscall             # terminate
end_main:  
#-------------------------------------
max:  add $v0, $a0, $0      # set max = a0
      slt $t0, $v0, $a1     # check if max < a1
      beq $t0, $0, continue # if false then skip 
      add $v0, $a1, $0      # if true then set max = a1
      continue:
      slt $t0, $v0, $a2     # check if max < a2
      beq $t0, $0, done     # if false then skip
      add $v0, $a2, $0      # if true then set max = a2
done: jr $ra                # return to calling program

