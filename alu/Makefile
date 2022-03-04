CC = gcc
CFLAGS = -no-pie
LDFLAGS = -no-pie

EXES = hello leaq_example addsub shift_example logic_example weighted_avg

%.o  : %.S
	$(CC) -c $(CFLAGS) -o $*.o $*.S

all : $(EXES)

hello : hello.o
	$(CC) $(LDFLAGS) -o $@ hello.o

leaq_example : leaq_example.o
	$(CC) $(LDFLAGS) -o $@ leaq_example.o

addsub : addsub.o
	$(CC) $(LDFLAGS) -o $@ addsub.o

shift_example : shift_example.o
	$(CC) $(LDFLAGS) -o $@ shift_example.o

logic_example : logic_example.o
	$(CC) $(LDFLAGS) -o $@ logic_example.o

weighted_avg : weighted_avg.o
	$(CC) $(LDFLAGS) -o $@ weighted_avg.o

clean :
	rm -f $(EXES) *.o
