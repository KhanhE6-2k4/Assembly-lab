.text
main: li $a1, -10 # load input parameter
      jal abs     # jump and link to abs procedure
      nop
      # print absolute value of a1
      add $a0, $v0, $0
      li $v0, 1
      syscall
      li $v0, 10
      syscall     # terminate
end_main:
#---------------------------------------------------
abs:  addi $v0, $a1, 0      # set v0 = a1
      slt $t0, $a1, $0      # check if a1 < 0
      beq $t0, $0, continue # if false then skip
      sub $v0, $0, $a1      # if true then set v0 = -(a1)
      continue:
      jr $ra
       
      
      
