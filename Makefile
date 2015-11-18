all: build

build:
	rm -rf build
	mkdir -p build
	cd build; cmake ..
	make -C build

test_stdin: build
	./build/scanner

test_example: build
	./build/scanner ./test/example.rst

.PHONY: build
