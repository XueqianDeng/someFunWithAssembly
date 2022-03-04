CC = gcc
CFLAGS = -g -no-pie
LDFLAGS = -no-pie

EXES = addLongs fibRec tricky3

%.o  : %.S
	$(CC) -c $(CFLAGS) -o $*.o $*.S

all : $(EXES)

addLongs : addLongs.o
	$(CC) $(LDFLAGS) -o $@ addLongs.o

fibRec : fibRec.o
	$(CC) $(LDFLAGS) -o $@ fibRec.o

tricky3 : tricky3.o
	$(CC) $(LDFLAGS) -o $@ tricky3.o

clean :
	rm -f $(EXES) *.o
