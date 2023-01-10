cls
flex *.l
bison -d *.y
gcc *.c -lfl -ly -o test
test.exe <exemple.txt

del lex.yy.c synt.tab.c synt.tab.h test.exe