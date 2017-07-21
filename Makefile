CC=gcc
CFLAGS=
DEPS = foo.h
OBJ = foo.o main.o

%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

foo: $(OBJ)
	gcc -o $@ $^ $(CFLAGS)

clean:
	@rm -f *.o *~ foo
