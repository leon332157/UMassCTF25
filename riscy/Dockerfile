FROM docker.io/ubuntu:plucky
WORKDIR /home/ctf

RUN useradd -d /home/ctf -u 1001 ctf
RUN echo "root:u6/bUtvr#}+(LR9phqPNJ&fk@7" | chpasswd
RUN echo "ctf:M2Fqa{wS#/Kf>[U]5kd^htg3QG" | chpasswd
RUN apt update
RUN apt install -y qemu-user
COPY --chown=root:root flag-real.txt ./flag.txt
COPY --chown=root:root ynetd ./ynetd
COPY --chown=root:root ./static/riscy ./riscy
RUN chmod +x ynetd
RUN chmod +x riscy
ENTRYPOINT ["./ynetd","-p","5555","-se","y","-u","ctf","qemu-riscv64 ./riscy"]
