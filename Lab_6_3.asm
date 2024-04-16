.data
A: .word 7, -2, 5, 1, 5, 6, 7, 3, 6, 8, 8, 59, 5 # Array A has n elements (in this ex n = 13)
A_end: .word                                     # A_end -> address of A[n]
.text 
# Bubble Sort (ascending sort using pointer)
main:        la $a0, A            # a0 -> address of A[0]
             la $a1, A_end 
             addi $a1, $a1, -4    # a1 -> address of A[n - 1]
             j start_sort         # perform sort
end_sort:    addi $v0, $0, 10     # exit
             syscall
end_main:
#---------------------------------------------------------------------------------------------
start_sort: beq $a0, $a1, end_sort # if list has 1 element then end_sort
            j swap
after_swap: addi $a1, $a1, -4      # decrement pointer to new last element
            j start_sort           # repeat sort for samller list with n - 1 elements
#---------------------------------------------------------------------------------------------
swap:       addi $t0, $a0, 0       # set t0 point to first
            addi $v1, $0, 1        # set swapped = 0 (To check if this list has change after swap)
LOOP:       beq $t0, $a1, DONE     # if first = last, done
            addi $t1, $t0, 4       # set t1 point to next element
            add $t2, $t0, $0       # set t2 point to current element
            addi $t0, $t1, 0      # set t0 point to next element  
            lw $s0, 0($t2)         # s0 = A[i]             
            lw $s1, 0($t1)         # s1 = A[i + 1]
            sub $s2, $s0, $s1      # s2 = A[i] - A[i+1]
            blez $s2, LOOP         # if A[i] <= A[i + 1], repeat
            sw $s0, 0($t1)         # swap A[i] with A[i + 1]
            sw $s1, 0($t2)
            addi $v1, $0, 1        # This list has some changes 
            j LOOP
DONE:       bne $v1, $0, after_swap # if this list has some changes, 
                                    # continue sorting
            j end_sort              # else finish sorting
           
            
            
