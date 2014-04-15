CC = gcc
CFLAGS += -g -std=c99
CFLAGS += -O2
CFLAGS += -Wshadow -Wall -Wno-unused-variable -Wno-error=unused-but-set-variable
CFLAGS += -Werror

CPPFLAGS = -D_GNU_SOURCE -D_DEBUG_ -I.

C_SRCS = base.c runtime.c builtin.c
OBJS = $(patsubst %.c,%.o,$(C_SRCS))

SCM = csc
SCM_SRCS = main.scm c_code.scm preprocessor.scm string.scm util.scm
SCM_FLAGS = -scrutinize

all: main

base.o: base.h
builtin.o: builtin.h
runtime.o: runtime.h

# Runtime library for compiled scm files
libruntime.a: $(OBJS)
	ar cvr $@ $^

# Main compiler binary, compiles the C runtime library first.
main: $(SCM_SRCS) libruntime.a
	$(SCM) $(SCM_FLAGS) $<

.PHONY: all clean
clean :
	-rm -f *.so *.o *.a main *.s *.i
	-find tests/ -not -iname '*.scm' -type f |xargs rm  2>/dev/null
