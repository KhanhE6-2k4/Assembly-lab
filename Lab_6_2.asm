.data
A: .word 7, -2, 5, 1, 5, 6, 7, 3, 6, 8, 8, 59, 5 # Array A has n elements (in this ex n = 13)
A_end: .word                                     # A_end -> address of A[n]
.text
# Selection Sort (ascending sort using pointer)
main:      la $a0, A              # a0 -> address of A[0]
           la $a1, A_end          
           addi $a1, $a1, -4      # a1 -> address of A[n - 1]
           j start_sort
end_sort:  addi $v0, $0, 10           # exit
           syscall
end_main:    
#----------------------------------------------------------------------------------------------
start_sort: beq $a0, $a1, end_sort      # if list has 1 element then end_sort
            j find_max                  # call the max procedure
after_max:  lw $s0, 0($a1)              # load last element to s0
            sw $s0, 0($t2)              # copy last element to A[idx_max] (idx_max is a position that A[position] has max value in this list)
            sw $t1, 0($a1)              # copy max value in this list to A[n - 1]
            addi $a1, $a1, -4           # decrement pointer to new last element          	
            j start_sort                # repeat sort for smaller list with n - 1 elements
#----------------------------------------------------------------------------------------------
find_max:   addi $t0, $a0, 0            # set next pointer to first
            lw $t1, 0($a0)              # set max value to first value
            addi $t2, $a0, 0            # set max pointer to first 
LOOP:       beq $t0, $a1, DONE          # if next = last , done
            addi $t0, $t0, 4            # point to next element
            lw $s2, 0($t0)              # get value of next element
            sub $t3, $s2, $t1           # get subtraction of next element value and max value
            blez $t3, LOOP              # if next element value <= max, repeat
            add $t1, $s2, $0            # else max value = next element value
            add $t2, $t0, $0            # set max pointer to next element
            j LOOP                      # change completed; now repeat 
DONE:       j after_max                 # Go to after_max after finding the max value                       