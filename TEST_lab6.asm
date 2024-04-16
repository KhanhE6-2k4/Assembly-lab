.data
A: .word 7, -2, 5, 1, 5, 6, 7, 3, 6, 8, 8, 59, 5

.text
addi $s0, $0, 13  # Number of elements = 13 (n = 13)
add $t0, $0, $0   # i = 0
la $s1, A         # s1 -> Base address of A


addi $t2, $s1, 0
LOOP: 
      slt $t1, $0, $s0 # Check if 0 < n
      beq $t1, $0, end_loop
      add $t4, $s1, $0 # t4 = add_max
      xor $t0, $0, $0  # i = 0
      lw $s2, 0($s1)    # max = s2 = A[0]
      L1: beq $t0, $s0, end_L1 # Check if i < n
          lw $s3, 0($t2)       # s3 = A[i]
          slt $t3, $s2, $s3    # if max < A[i] -> add_max = address of A[i], max = A[i]
          beq $t3, $0, continue
          add $t4, $0, $t2     # add_max = address of A[i]
          add $s2, $0, $s3     # max = A[i]
          continue:
          addi $t0, $t0, 1    # i = i + 1
          addi $t2, $t2, 4    # t2 -> address of A[i]
          j L1
      end_L1:
      addi $t2, $t2, -4       # t2 -> address of A[n - 1]
      lw $s5, 0($t2)          # s5 = A[n - 1]
      sw $s5, 0($t4)          # A[idx_max] = A[n - 1]
      sw $s2, 0($t2)          # A[n - 1] = max
      addi $t2, $s1, 0           # t2 -> address of A[0]
      addi $s0, $s0, -1       # n = n - 1
      j LOOP
end_loop: