# Extract MSB of $s0 to $s1 (1)
# Clear LSB of $s0 (make a copy and save to $s2) (2)
# Set LSB of $s0 (make a copy and save to $s3)  (3)
# Clear $s0 (must use logical instructions)    (4)


.text
start:
lui $s0, 0x1234        # load 0x12345678 to $s0
ori $s0, $s0, 0x5678
# (1)
lui $t0, 0xff00        # load 0xff000000 to $t0
ori $t0, $t0, 0x0      
and $s1, $s0, $t0      # Extract MSB of $s0 and load it to $s1
# (2)
srl $s2, $s0, 8        # shift $s0 right by 8 bits and load result to $s2
sll $s2, $s2, 8        # shift $s2 left by 8 bits
# (3)
ori $s3, $s0, 0x00ff   # Set LSB of $s0 and load result to $s3 (all bits of LSB = 1)
# (4)
and $s0, $s0, $0       # Clear $s0 (all bits are 0)
end:




 
