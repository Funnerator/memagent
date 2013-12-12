ARCH := $(shell uname -m)
X64 = x86_64
PROGS = magent

LIBS = -levent -lm $(shell pkg-config --libs glib-2.0)

CFLAGS = -Wall -g  `pkg-config --cflags glib-2.0`

all: $(PROGS)

STPROG = magent.o ketama.o log.o 

magent: $(STPROG) 
	$(CC) $(CFLAGS) -o $@ $^ $(LIBS)
magent.o: magent.c  log.h config.h 
	$(CC) $(CFLAGS) -c -o $@ magent.c
ketama.o: ketama.c ketama.h
	$(CC) $(CFLAGS) -c -o $@ ketama.c

	
log.o: log.c log.h
	$(CC) $(CFLAGS) -c -o $@ log.c


install:
	mkdir -p /usr/local/bin
	cp magent /usr/local/bin
	cp scripts/magent /etc/init.d/magent

clean: 
	rm -f *.o *~ $(PROGS)
