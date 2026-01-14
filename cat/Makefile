CFLAGS = -std=c11 -Wall -Wextra -Werror

.PHONY: all test clean rebuild

all: my_cat

my_cat: main.c my_cat.c my_cat.h
	 gcc $(CFLAGS) -o my_cat main.c my_cat.c

test: my_cat
	chmod +x test_cat.sh
	./test_cat.sh
    
clean:
	 rm -f my_cat
    
rebuild: clean all
