# Copyright (C) 2017 Rafael Sene
# Licensed under the Apache License, Version 2.0 (the “License”);
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# http://www.apache.org/licenses/LICENSE-2.0
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an “AS IS” BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# Contributors:
#         * Rafael Sene <rpsene@gmail.com>

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
