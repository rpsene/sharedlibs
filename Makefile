CC=gcc
CFLAGS=-Wall -Werror -fpic
DEPS = foo.h
OBJ = foo.o main.o

%.o: %.c $(DEPS)
	@$(CC) -c -o $@ $< $(CFLAGS)

foo: $(OBJ)
	@gcc -o $@ $^ $(CFLAGS)
	@echo "Build is done!"

clean:
	@rm -f *.o *~ foo
	@echo "Cleanup is done!"
