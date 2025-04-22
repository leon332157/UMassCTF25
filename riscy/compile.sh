riscv64-unknown-linux-gnu-gcc -Wall -O0 -o static/riscy riscy.c -no-pie -fno-stack-protector -z execstack -static -mno-plt -march=rv64g
sha256sum static/riscy
