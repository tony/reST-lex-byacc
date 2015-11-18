all:
	flex
	build

flex:
	flex scan.l

build: flex
	clang lex.yy.c -o scan -lfl

test_stdin: build
	./scan

test_example: build
	./scan ./test/example.rst

yacc:
	yacc -d gram.y

.PHONY: flex build
