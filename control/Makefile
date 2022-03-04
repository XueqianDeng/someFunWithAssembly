CC = gcc
CFLAGS = -g -no-pie
LDFLAGS = -no-pie

EXES = vote months fib tricky tricky2

%.o  : %.S
	$(CC) -c $(CFLAGS) -o $*.o $*.S

all : $(EXES)

vote : vote.o
	$(CC) $(LDFLAGS) -o $@ vote.o

months : months.o
	$(CC) $(LDFLAGS) -o $@ months.o

fib : fib.o
	$(CC) $(LDFLAGS) -o $@ fib.o

tricky : tricky.o
	$(CC) $(LDFLAGS) -o $@ tricky.o

tricky2 : tricky2.o
	$(CC) $(LDFLAGS) -o $@ tricky2.o

clean :
	rm -f $(EXES) *.o
