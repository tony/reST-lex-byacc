all: build

mkdir_build:
	rm -rf build
	mkdir -p build

build: mkdir_build
	cd build; cmake ..
	make -C build

build_ninja: mkdir_build
	cd build; cmake -GNinja ..
	ninja -C build

debug: mkdir_build
	cd build; cmake -DCMAKE_BUILD_TYPE=Debug ..
	make -C build

debug_ninja: mkdir_build
	cd build; cmake -GNinja -DCMAKE_BUILD_TYPE=Debug ..
	ninja -C build

watch_debug:
	if command -v entr > /dev/null; then find . -type f -not -path '*/\.*' -and -not -path '*/build/*' | grep -i '.*[.][c,h]' | entr -c make debug_ninja; else make debug_ninja; echo "\nInstall entr(1) to automatically run tests on file change.\n See http://entrproject.org/"; fi

test_stdin: build
	./build/scanner

test_example: build
	./build/scanner ./test/example.rst

format:
	clang-format -style=Chromium src/* -i || clang-format38 -style=Chromium src/* -i

.PHONY: mkdir_build
