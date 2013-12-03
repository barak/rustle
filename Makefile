CC = gcc
CFLAGS = -g -Werror -Wshadow -std=c99 -Wall -Wno-unused-variable -Wno-error=unused-but-set-variable -D_GNU_SOURCE -I.

C_SRCS = base.c runtime.c builtin.c
OBJS = $(patsubst %.c,%.o,$(C_SRCS))

SCM = csc
SCM_FLAGS = -scrutinize

all: main

%.o: %.c
	$(CC) -c -o $@ $< $(CFLAGS)

runtime.a: $(OBJS)
	ar cr runtime.a $^

main: main.scm runtime.a
	$(SCM) $(SCM_FLAGS) $<

.PHONY: clean
clean :
	-rm -f *.so *.o *.a main
