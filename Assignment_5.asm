# The power load in $s2
# The number to be multiplied load in $s1
# The result load in $s3
.text
start:
addi $s1, $0, 5 # number to be multiplied = 5
addi $s2, $0, 10 # power = 10
sllv $s3, $s1, $s2 # $s3 = 5 * (2 ^ 4)
exit:
