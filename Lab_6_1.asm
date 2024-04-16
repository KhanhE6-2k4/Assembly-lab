.data
message1: .asciiz "The maximum sum: "
message2: .asciiz "The lenght of prefix sub_array: "
A: .word -2, 6, -1, 3, -2

.text 
# t1 = maximum-sum, t0 = the lenght of prefix sub-array of A
main:     la $a0, A              # a0 -> address of A[0]
          addi $a1, $0, 5        # The lenght of this array = a1 = 5 (n = 5)
          slt $t0, $0, $a1       # Check if the lenght of this array greater than zero
          bne $t0, $0, function  # if true then branch to function 
          j exit                 # else exit program
end_main: addi $v0, $0, 56       # print maximum sum
          la $a0, message1 
          add $a1, $0, $t1
          syscall
          addi $v0, $0, 56       # print the lenght of max_sum prefix sub_array
          la $a0, message2
          add $a1, $0, $t0
          syscall
exit:     addi $v0, $0, 10       # exit
          syscall
 
#-------------------------------------------------------------------------
function: addi $t0, $0, 1        # init the lenght of sub_array of A in which max sum reachs = 1
          lw $t1, 0($a0)         # set max_sum of a certain sub_array = A[0]
          add $t2, $t1, $0       # set current_sum = A[0]
          xor $s0, $0, $0        # i = 0
LOOP:     beq $s0, $a1, DONE     # if i = n then DONE
          addi $s0, $s0, 1       # i = i + 1
          sll $t3, $s0, 2        # t3 = 4 * i
          add $a2, $a0, $t3      # a2 -> address of A[i]
          lw $t4, 0($a2)         # t4 = A[i]
          add $t2, $t2, $t4      # current_sum = current_sum + A[i]
          slt $t5, $t1, $t2      # check if max_sum < current_sum
          beq $t5, $0, continue  # if not true then continue
          add $t1, $0, $t2       # else max_sum = current_sum
          addi $t0, $s0, 1       # lenght of sub_array = i + 1
          continue:
          j LOOP
DONE:     j end_main
