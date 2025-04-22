nasm -f elf64 -o syscalls.o syscalls.S
nasm -f elf64 -o vec.o vec.S
c3c compile main.c3 syscalls.o vec.o -o debug --x86cpu=avx1 --x86vec=avx -vv --optlevel=none --optsize=none --target linux-x64 --reloc=none --link-libc=yes --use-stdlib=yes --safe=no -g
#strip main
