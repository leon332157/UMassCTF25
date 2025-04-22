bits 64
;.global read_syscall

section .text
global open_syscall
open_syscall:
    mov rax, 2          ;syscall number for sys_open
    mov rdi, rdi        ;filename (passed in rdi)
    mov rsi, rsi        ;flags (passed in rsi)
    mov rdx, rdx        ;mode (passed in rdx)
    syscall
    ret
global read_syscall
read_syscall:
    mov rax, 0          ;syscall number for sys_read
    mov rdi, rdi        ;file descriptor (passed in rdi)
    mov rsi, rsi        ; buffer (passed in rsi)
    mov rdx, rdx        ; count (passed in rdx)
    syscall
    ret
global write_syscall
write_syscall:
    mov rax, 1          ;syscall number for sys_write
    mov rdi, rdi        ;file descriptor (passed in rdi)
    mov rsi, rsi        ; buffer (passed in rsi)
    mov rdx, rdx        ; count (passed in rdx)
    syscall
    ret

global exit_syscall
exit_syscall:
    mov rax, 0x3c         ;syscall number for sys_exit
    syscall
    ret