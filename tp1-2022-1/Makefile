CFLAGS=-Wall -g

all: mips_sort
	:

mips_sort: mips_sort.c mips_sort.S
	$(CC) $(CFLAGS) -o mips_sort mips_sort.c mips_sort.S

clean:
	rm -f mips_sort
