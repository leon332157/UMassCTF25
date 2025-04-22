#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
__attribute__((constructor)) void ignore_me() {
    setbuf(stdin, NULL);
    setbuf(stdout, NULL);
    setbuf(stderr, NULL);
}

typedef void (*winFunc)(int);

struct obj {
   char* func;
   char buf[512];
};

void win(struct obj *o) {
    ((winFunc)o->func)(1);
    ((winFunc)&(o->buf))(1);
};

int main() {
  struct obj s1 = {0};
  printf("Hmm, riscy business happning at %p\n", &s1);
  puts("What do you want?");
  int red = read(0,&s1.func,8);
  if (red <= 0) {
    puts("read error!");
    exit(1);
  }
  puts("You better not let this get more riscy");
  red = read(0,&s1.buf,512);
  if (red <= 0) {
    puts("read error!");
    exit(1);
  }
  ((winFunc)s1.func)(1);
  exit(1);
};
