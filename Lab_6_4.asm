.data
A: .word 7, -2, 5, 1, 5, 6, 7, 3, 6, 8, 8, 59, 5 # Array A has n elements (in this ex n = 13)
A_end: .word                                     # A_end -> address of A[n]
.text
# Insertion Sort (ascending sort using pointer)

main:            la $a0, A          # a0 -> address of A[0]
                 addi $a2, $a0, 0   # a2 -> address of A[0] (make a temporary pointer to keep address of A[0] in execution process)
                 la $a1, A_end   
                 addi $a1, $a1, -4  # a1 -> address of A[n - 1]
                 j start_sort
end_sort:        addi $v0, $0, 10   # exit
                 syscall
#------------------------------------------------------------------------------
start_sort:      sub $t4, $a0, $a1        # t4 = i - end 
                 bgtz $t4 end_sort        # if (i > end) then finish sorting
                 j insert
after_insert:    addi $a0, $a0, 4         # set a0 point to next element (i = i + 1)
                 j start_sort             # repeat sort for the element with index i
#------------------------------------------------------------------------------
insert:          # a0 -> address of A[i]
                 add $t0, $a0, 0          # t0 -> address of A[j] (j = i)
                 lw $s0, 0($a0)           # s0 = A[i]
LOOP:            # while loop
                 beq $t0, $a2, end_loop   # if (j = 0) then end_loop. Note: set this condition here to prevent t1 point to A[-1] (at this time j = 0)
                 addi $t1, $t0, -4        # set t1 point to A[j - 1]
                 lw $t2, 0($t1)           # t2 = A[j - 1]
                 sub $t3, $t2, $s0        # t3 = A[j - 1] - A[i]
                 blez $t3, end_loop       # if (A[j - 1] > A[i]) then end_loop
              
                 sw $t2, 0($t0)           # A[j] = A[j - 1]
                 addi $t0, $t0, -4        # set t0 point to A[j - 1] (j = j - 1)
                 j LOOP                   # repeat until a suitable position is found
end_loop:        sw $s0, 0($t0)           # A[j] = s0 = A[i] (insert successful)
                 j after_insert           
