CC=gcc
CFLAGS=-Wall -Werror -Wextra -O3 -fpic
DEPS=foo.h
OBJ=foo.o main.o
LDFLAGS=-shared
RM=rm -f
TARGET_LIB=foo.so
SRCS=main.c foo.c
OBJS=$(SRCS:.c=.o)
NAME=foo
ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

lib: lib$(NAME).so

shared: $(NAME)
	@echo
	@echo "Step 4: Making the library available at runtime..."
	$(CC) -L$(ROOT_DIR) -Wl,-rpath=$(ROOT_DIR) -o $(NAME)_test main.c -l$(NAME)

$(NAME): lib$(NAME).so
	@echo
	@echo "Step 3: Linking with a shared library..."
	$(CC) main.c -o $@ -L$(ROOT_DIR) -l$(NAME)

lib$(NAME).so: $(NAME).o
	@echo
	@echo "Step 2: Creating shared library..."
	$(CC) -shared -Wl,-soname,lib$(NAME).so $^ -o $@

run: $(NAME)_test
	@echo
	@echo "Step 5: Running..."
	@$(ROOT_DIR)/$(NAME)_test

clean:
	@$(RM) $(NAME) $(NAME)_test *.o *.so* *.d
	@echo "Cleanup done!"
