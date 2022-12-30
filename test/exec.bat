cls
flex *.l
bison -d *.y
gcc lex.yy.c synt.tab.c -lfl -ly -o test
test.exe <exemple.txt
