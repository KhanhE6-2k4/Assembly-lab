.data
student: .space 2400 # space to store information of each student (maximum 100 students)
                     # each student has 24 bytes: 20 bytes for name and 4 bytes for mark
output: .asciiz "\nAll students who haven't passed the Math exam: \n"
input1: .asciiz "Enter the number of students: "
input2: .asciiz "Enter information about each student: "
mes1: .asciiz "\nRoll number "
mes2: .asciiz "\nEnter name: "
mes3: .asciiz "Enter mark: "
mes4: .asciiz "----------------------------"

.text
main:
addi $v0, $0, 4      # Enter the number of students:
la $a0, input1
syscall
addi $v0, $0, 5      # get number of students
syscall 
addi $t0, $v0, 0     # t0 = n = numbers of students
addi $t1, $0, 0      # i = 0 
addi $v0, $0, 4
la $a0, input2
syscall
la $t3, student      # Load the address of the array of structures representing students (t3)
add $s0, $0, $t3     # s0 = t3 = address of the array of structures representing students
addi $a1, $0, 19     # the maximum lenght of name is 19
L1: slt $t2, $t1, $t0   # check if i < n
    beq $t2, $0, end_L1 # if false then end loop
    addi $v0, $0, 4     # roll number 
    la $a0, mes1
    syscall
    addi $v0, $0, 1     # ordinal number of this student (STT)    
    addi $a0, $t1, 1    # a0 = i + 1
    syscall
    addi $v0, $0, 4     # Enter name:
    la $a0, mes2
    syscall   
    addi $v0, $0, 8     # read name of the student
    addi $a0, $s0, 0
    syscall
    addi $v0, $0, 4     # Enter mark: 
    la $a0, mes3
    syscall
    addi $a0, $s0, 20   # a0 = address of this student's mark
    addi $v0, $0, 5     # enter this student's mark
    syscall
    sw $v0, 0($a0)       
    addi $v0, $0, 4
    la $a0, mes4
    syscall
    addi $s0, $s0, 24    # move to next student
    addi $t1, $t1, 1    # i = i + 1
    j L1                # jump to L1
end_L1:
addi $v0, $0, 4        
la $a0, output
syscall
addi $t1, $0, 0         # set i = 0
la $a0, student         # a0 = t2   
addi $t5, $0, 4         # set the minimum mark to pass 
L2: slt $t2, $t1, $t0   # check if i < n
    beq $t2, $0, end_L2 # if false then end loop
    lw $t4, 20($a0)     # get this student's mark
    slt $t2, $t4, $t5   # check if this student's mark < minimun mark
    beq $t2, $0, skip   # if false then skip
    addi $v0, $0, 4     # else print this student's name
    syscall
    skip:
    addi $a0, $a0, 24   # move to next student
    addi $t1, $t1, 1    # i = i + 1
    j L2                # jump to L2
end_L2:
end_main:

    
                        
    
    
    