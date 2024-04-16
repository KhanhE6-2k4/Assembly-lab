# a. abs $s0, $s1
# b. move $s0, $s1
# c. not $s0
# d. ble $s1, $s2, L 

.text
start:
addi $s1, $0, -6    # set $s1 = -6
addi $s2, $0, 5     # set $s2 = 5
# a)
bltz $s1, negative  # Test if $s1 is negative
add $s0, $0, $s1    # $s0 = $s1
j end_a
negative: # $s1 < 0
          sub $s0, $0, $s1 # $s0 = -$s1
end_a:

# b)
add $s0, $s1, $0 # $s0 = $s1 + 0 = $s1
end_b:

# c)
# Note: a nor a = not(a)
nor $s0, $s0, $s0       # Set $s0 to NOT($s0) (Invert bits of $s0)
end_c:
# d)
sub $t3, $s1, $s2 # $t3 = $s1 - $s2
blez $t3, L       # Branch to L if ($s1 - $s2 <= 0)
j end_d
L:
# some instructions ...

end_d:




          

