.data
message: .asciiz "Xin chao"
.text
addi $v0, $0, 4
la $a0, message
syscall
