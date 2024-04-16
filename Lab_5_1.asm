.data
message: .asciiz "Xin chao"
.text
addi $v0, $0, 4  # service 4 is print string
la $a0, message  # load the address of message to $a0
syscall          # execute
