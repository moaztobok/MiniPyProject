cls
flex *.l
bison -d *.y
gcc *.c -lfl -ly -o test
./test
