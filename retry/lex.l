%{
    #include <stdlib.h>
    #include <stdio.h>
    #include "lex.h"
    #include "ts.h"
    
    extern yylineo,Col;
    void rechercher(char entite[], char code[], char type[], float val, int y);
    
%}

lettreM [A-Z]
lettre [a-z{lettreM}]
chiffre [0-9]
com ^#.*
IDF {lettreM}({chiffre}|{lettre})*(_{chiffre}|{lettre})*
CST {chiffre}+
CSTN (-{CST})
FLT {CST}\.{CST}
FLTN (-{FLT})
char '|"{lettre}'|"
bool (true)|(false)
%%
{com}   {
    Fpos(); 
    fprintf(O_lex,"commentaire: %s\n",yytext);
    Col+=yyleng;
}
\n  {Col=1; yylineo++;}
" " Col++;
\t  {Col+=yyleng;}
{IDF}   {
    Fpos();
    rechercher(yytext,"IDF","",0,0);
    Col+=yyleng;
    if (yyleng>8){
        fprintf("Erreur lexicale: IDF trop long %s\n",yytext);
    }else{
        fprintf(O_lex,"Identificateur: %s\n",yytext);
        return idf; //token de IDF allant vers sytaxique.y
    }
}

