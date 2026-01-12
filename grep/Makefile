CFLAGS = -std=c11 -Wall -Wextra -Werror

.PHONY: all test clean rebuild

all: my_grep

my_grep: main.c my_grep.c my_grep.h
	 gcc $(CFLAGS) -o my_grep main.c my_grep.c

test: my_grep
	chmod +x test_grep.sh
	./test_grep.sh
    
clean:
	 rm -f my_grep
    
rebuild: clean all
