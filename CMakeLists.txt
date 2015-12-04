cmake_minimum_required(VERSION 3.3)

find_package(FLEX)
include_directories(${FLEX_INCLUDE_DIRS} ${CMAKE_CURRENT_SOURCE_DIR})

file(GLOB SRC_FILES src/*.c)
file(GLOB HEADER_FILES src/*.h)

flex_target(scanner src/scan.l ${CMAKE_CURRENT_BINARY_DIR}/lex.yy.c)

add_executable(
	scanner
	${FLEX_scanner_OUTPUTS}
)

target_link_libraries(scanner ${FLEX_LIBRARIES})
