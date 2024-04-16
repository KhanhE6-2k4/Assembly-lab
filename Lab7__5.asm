.data
mes1: .asciiz "Largest: "    # Chuỗi ký tự "Largest: " để in ra màn hình
mes2: .asciiz " Smallest: "   # Chuỗi ký tự " Smallest: " để in ra màn hình

.text
main:
    # Khởi tạo các giá trị cho các thanh ghi s0-s7
    addi $s0, $0, 6   # s0 = 2
    addi $s1, $0, 2   # s1 = 1
    addi $s2, $0, -8  # s2 = -3
    addi $s3, $0, 1   # s3 = 4
    addi $s4, $0, 3   # s4 - 0
    addi $s5, $0, 4   # s5 = 7
    addi $s6, $0, -7   # s6 = 9
    addi $s7, $0, 0   # s7 = 4

    # Gọi hàm find_max để tìm giá trị lớn nhất và vị trí của nó
    jal find_max
    addi $t0, $v0, 0  # t0 = largest (giá trị lớn nhất)
    addi $t1, $v1, 0  # t1 = largest position (vị trí của giá trị lớn nhất)

    # In giá trị lớn nhất và vị trí của nó
    addi $v0, $0, 4    # syscall để in chuỗi ký tự
    la $a0, mes1       # Load địa chỉ của chuỗi "Largest: "
    syscall
    addi $v0, $0, 1    # syscall để in số nguyên
    addi $a0, $t0, 0   # Load giá trị lớn nhất
    syscall
    addi $v0, $0, 11   # syscall để in ký tự dấu phẩy ','
    addi $a0, $0, 44
    syscall
    addi $v0, $0, 1    # syscall để in vị trí của giá trị lớn nhất
    addi $a0, $t1, 0   # Load vị trí của giá trị lớn nhất
    syscall

    # Gọi hàm find_min để tìm giá trị nhỏ nhất và vị trí của nó
    jal find_min
    addi $t2, $v0, 0  # t2 = smallest (giá trị nhỏ nhất)
    addi $t3, $v1, 0  # t3 = smallest position (vị trí của giá trị nhỏ nhất)

    # In giá trị nhỏ nhất và vị trí của nó
    addi $v0, $0, 4    # syscall để in chuỗi ký tự
    la $a0, mes2       # Load địa chỉ của chuỗi " Smallest: "
    syscall
    addi $v0, $0, 1    # syscall để in số nguyên
    addi $a0, $t2, 0   # Load giá trị nhỏ nhất
    syscall
    addi $v0, $0, 11   # syscall để in ký tự dấu phẩy ','
    addi $a0, $0, 44
    syscall
    addi $v0, $0, 1    # syscall để in vị trí của giá trị nhỏ nhất
    addi $a0, $t3, 0   # Load vị trí của giá trị nhỏ nhất
    syscall

    # Kết thúc chương trình
exit:  
    addi $v0, $0, 10   # syscall để kết thúc chương trình
    syscall

#----------------------------------------------
find_max: # Hàm để tìm giá trị lớn nhất và vị trí của nó
    sw $fp, -4($sp)    # Lưu trữ frame pointer
    addi $fp, $sp, 0   # fp = sp
    addi $sp, $sp, -40 # Cấp phát không gian trên stack
    sw $ra, 32($sp)    # Lưu trữ địa chỉ trở về
    sw $s7, 28($sp)    # Lưu trữ s7
    sw $s6, 24($sp)    # Lưu trữ s6
    sw $s5, 20($sp)    # Lưu trữ s5
    sw $s4, 16($sp)    # Lưu trữ s4
    sw $s3, 12($sp)    # Lưu trữ s3
    sw $s2, 8($sp)     # Lưu trữ s2
    sw $s1, 4($sp)     # Lưu trữ s1
    sw $s0, 0($sp)     # Lưu trữ s0

    add $v0, $s0, $0   # Khởi tạo giá trị lớn nhất là s0
    addi $v1, $0, 0    # Khởi tạo vị trí của giá trị lớn nhất là 0
    addi $t0, $0, 1    # Khởi tạo i = 0
    addi $t1, $0, 8    # Số lượng thanh ghi là 8

L1: 
    slt $t2, $t0, $t1     # Kiểm tra nếu i < 8
    beq $t2, $0, end_1 # Nếu không, kết thúc vòng lặp
    sll $t2, $t0, 2       # Tính toán offset của thanh ghi trên stack
    add $t2, $sp, $t2     # Tính địa chỉ của thanh ghi
    lw $t2, 0($t2)
     slt $t3, $v0, $t2     # So sánh giá trị hiện tại với giá trị lớn nhất
    beq $t3, $0, skip_1 # Nếu không, tiếp tục với vòng lặp
    add $v0, $t2, $0      # Nếu có, cập nhật giá trị lớn nhất
    add $v1, $t0, $0      # Cập nhật vị trí của giá trị lớn nhất
skip_1:
    addi $t0, $t0, 1      # Tăng giá trị của i lên 1
    j L1               # Quay lại vòng lặp

end_1:
    addi $sp, $fp, 0      # Khôi phục giá trị của stack pointer
    lw $fp, -4($sp)       # Khôi phục frame pointer
    jr $ra                # Trở về địa chỉ gọi
find_min: # Hàm để tìm giá trị nhỏ nhất và vị trí của nó
    sw $fp, -4($sp)    # Lưu trữ frame pointer
    addi $fp, $sp, 0   # fp = sp
    addi $sp, $sp, -40 # Cấp phát không gian trên stack
    sw $ra, 32($sp)    # Lưu trữ địa chỉ trở về
    sw $s7, 28($sp)    # Lưu trữ s7
    sw $s6, 24($sp)    # Lưu trữ s6
    sw $s5, 20($sp)    # Lưu trữ s5
    sw $s4, 16($sp)    # Lưu trữ s4
    sw $s3, 12($sp)    # Lưu trữ s3
    sw $s2, 8($sp)     # Lưu trữ s2
    sw $s1, 4($sp)     # Lưu trữ s1
    sw $s0, 0($sp)     # Lưu trữ s0

    add $v0, $s0, $0   # Khởi tạo giá trị nhỏ nhất là s0
    addi $v1, $0, 0    # Khởi tạo vị trí của giá trị nhỏ nhất là 0
    addi $t0, $0, 1    # Khởi tạo i = 0
    addi $t1, $0, 8    # Số lượng thanh ghi là 8

L2: 
    slt $t2, $t0, $t1     # Kiểm tra nếu i < 8
    beq $t2, $0, end_2 # Nếu không, kết thúc vòng lặp
    sll $t2, $t0, 2       # Tính toán offset của thanh ghi trên stack
    add $t2, $sp, $t2     # Tính địa chỉ của thanh ghi
    lw $t2, 0($t2)        # Load giá trị của thanh ghi
    slt $t3, $t2, $v0     # So sánh giá trị hiện tại với giá trị nhỏ nhất
    beq $t3, $0, skip_2 # Nếu không, tiếp tục với vòng lặp
    add $v0, $t2, $0      # Nếu có, cập nhật giá trị nhỏ nhất
    add $v1, $t0, $0      # Cập nhật vị trí của giá trị nhỏ nhất
skip_2:
    addi $t0, $t0, 1      # Tăng giá trị của i lên 1
    j L2               # Quay lại vòng lặp

end_2:
    addi $sp, $fp, 0      # Khôi phục giá trị của stack pointer
    lw $fp, -4($sp)       # Khôi phục frame pointer
    jr $ra                # Trở về địa chỉ gọi