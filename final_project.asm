.data
input: .asciiz "Nhap chuoi ki tu : "
string: .space 100

d1: .asciiz "     Disk 1"
d2: .asciiz "     Disk 2"
d3: .asciiz "     Disk 3"
line: .asciiz " --------------        --------------        --------------"
space: .asciiz "           "
new_line: .asciiz "\n"
c1: .asciiz "|     "
c2: .asciiz "     |"
c3: .asciiz "[[ "
c4: .asciiz "]]"
space1: .asciiz "      " # 6 space

.text
main:
li $t6, 4 # length of each block (4 byte)
li $t4, 3 # n = 3

la $a0, input    # print "Nhap chuoi ki tu: "
li $v0, 4
syscall

la $a0, string  # get input string
li $a1, 100
li $v0, 8
syscall
#--------------------------------------
la $a0, d1   # print "Disk 1"
li $v0, 4
syscall

la $a0, space
li $v0, 4
syscall

la $a0, d2   # print "Disk 2"
li $v0, 4
syscall

la $a0, space
li $v0, 4
syscall

la $a0, d3   # print "Disk 3"
li $v0, 4
syscall

la $a0, new_line
li $v0, 4
syscall

la $a0, line # print horizontal line
li $v0, 4
syscall

la $a0, new_line
li $v0, 4
syscall
#----------------------------------------------
li $t0, 0 # i = 0
la $s0, string # get the address of input string
L1: lbu $t1, 1($s0)   # if program encounter a null character then the data writing procedure is complete  
    beq $t1, $0, end_loop
    jal RAID5         # Go to RAID5 procedure
    addi $t0, $t0, 1  # i = i + 1
    addi $s0, $s0, 8  # move to data in next row
    j L1
end_loop:

la $a0, line          # print horizontal line
li $v0, 4
syscall

end_main: li $v0, 10
syscall
#----------------------------------------------
RAID5: 
sw $fp, -4($sp) # save frame pointer
addi $fp, $sp, 0 # new frame pointer to stack's
addi $sp, $sp, -8 # allocate space
sw $ra, 0($sp)    # save return address

add $a2, $s0, $0   # a2 -> address of current block 
div $t0, $t4
mfhi $t1    # get the remainder of i / 3
li $t5, 1   # t5 = 1
# WRITE DATA
switch_case: 

case0: bne $t1, $0, case1          # if i $ 3 = 0 then write data with this order
       jal print_block
       jal print_block
       jal print_parity
       
       j end_sc
       
case1: bne $t1, $t5, default       # if i $ 3 = 1 then write data with this order
       jal print_block
       jal print_parity
       jal print_block
       
       j end_sc
default:                           # else write data with this order
       jal print_parity
       jal print_block
       jal print_block
 
end_sc:  # end switch case

la $a0, new_line
li $v0, 4
syscall

lw $ra, 0($sp)     # restore return address
addi $sp, $fp, 0   # restore stack pointer
lw $fp, -4($sp)    # restore frame pointer
jr $ra             # return to main program
#-----------------------------------------------------
print_block:  # procedure to write block data to Disk
       
       la $a0, c1
       li $v0, 4
       syscall
       li $t3, 0  # j = 0
       for: beq $t3, $t6, end_for # if j = 4 then end for
            lbu $a0, 0($a2) # get each byte (each character) then write sequentially to disk
            li $v0, 11
            syscall
            addi $a2, $a2, 1  # a2 = a2 + 1 (move to next character)
            addi $t3, $t3, 1  # j = j + 1
            j for
       end_for:
       la $a0, c2
       li $v0, 4
       syscall
       
       la $a0, space1
       li $v0, 4
       syscall
jr $ra        # return to RAID5 procedure
#-----------------------------------------------------
print_parity: # procedure to write 4 byte parity from two block in remaining disk
      sw $fp, -4($sp)   # store frame pointer
      addi $fp, $sp, 0  # new frame pointer to stack's
      addi $sp, $sp, -8 # allocate space
      sw $ra, 0($sp)    # store return address
      la $a0, c3
      li $v0, 4
      syscall
      
      addi $s1, $s0, 0  # s1 -> base address of first block
      li $t3, 0  # j  = 0
      for1: 
            li $t5, 0x0000000F  # make a Bit_mark to get 4 low bits
            lbu $t8, 0($s1)
            lbu $t9, 4($s1)
            xor $s2, $t8, $t9
            and $t9, $s2, $t5   # t8 = 4 lower bits
            srl $s2, $s2, 4     # shift right s2 4 bits
            and $t8, $s2, $t5   # t9 = 4 higher bits
            
            addi $a0, $t8, 0 # print t8 in hexadecimal
            jal print_hexa
            addi $a0, $t9, 0 # print t9 in hexadecimal
            jal print_hexa
            
            addi $t3, $t3, 1  # j = j + 1
            addi $s1, $s1, 1  # s1 = s1 + 1
            
            beq $t3, $t6, end_for1 # if j = 4 then end for1 
             
            print_comma: 
                         li $v0, 11        # print comma 
                         li $a0, 44        # ascii code of ',' is 44
                         syscall      
            
            j for1            # return to loop
      end_for1:
      
      la $a0, c4
      li $v0, 4
      syscall
      
      la $a0, space1
      li $v0, 4
      syscall
      
      lw $ra, 0($sp)   # restore return address
      addi $sp, $fp, 0 # restore stack pointer
      lw $fp, -4($sp)  # restore frame pointer
      jr $ra           # return to RAID5 procedure
#------------------------------------------------------------
print_hexa:
      li $t5, 10
      slt $t1, $a0, $t5  # if a0 < 10 then print a0 
      beq $t1, $0, else
      li $v0, 1
      syscall
      j end_if
else: addi $a0, $a0, -10  # a0 = a0 - 10 + 'a'  
      addi $a0, $a0, 97   # ascii code of 'a' is 97
      li $v0, 11
      syscall
end_if:
jr $ra  # return to print_parity procedure
      
 


