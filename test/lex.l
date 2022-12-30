%{
    #include<stdlib.h>
    #include<stdio.h>
    #include "synt.tab.h"
    #include "lex.h"
%}
com ^#.*
lettreM [A-Z]
lettre [a-z{lettreM}]
chiffre [0-9]
char "|'{lettre}"|'
bool (true)|(false)
IDF {lettreM}({lettre}|{chiffre})*(_{lettre}|{chiffre})*
cstint {chiffre}+
float {chiffre}+\.{chiffre}+
FLT (-{float})|{float}
CST (-{cstint})|{cstint}
%%
int {
    pos(); 
    Col+=yyleng;
    return mc_int;
}
float {
    pos(); 
    Col+=yyleng;
    return mc_float;
}
char {
    pos(); 
    Col+=yyleng;
    return mc_car;
}
bool {
    pos(); 
    Col+=yyleng;
    printf("declaration boolean \n"); Col+=yyleng;
   
   return mc_bool;
}
if {
   pos();
   printf("Bloq_con_if \n"); Col+=yyleng;
     
   return mc_if;
}
else {
   pos();
   printf("declaration else \n"); Col+=yyleng;
      
   return mc_else;
}
while {
   pos();
   printf("Boucle while \n"); Col+=yyleng;
     
   return mc_while;
}
for {
   pos();
   printf("Boucle for \n"); Col+=yyleng;
      
   return mc_for;
}
in {
   pos();
   printf("in \n"); Col+=yyleng;
    
   return mc_in;
}
"in range" {
   pos();
   printf("range \n"); Col+=yyleng;
   
   return mc_in_range;
}
{IDF}   {
    pos(); 
    Col+=yyleng;
    return idf;
}
{CST}   {
    pos(); 
    Col+=yyleng;
    yylval.ent=atoi(yytext);
    return val_int;
}
{FLT}   {
    pos(); 
    Col+=yyleng;
    yylval.reel=atof(yytext);
    return val_float;
}
{char} {
    pos(); 
    Col+=yyleng;
    yylval.car=yytext[1];
    return val_car; 
}
{bool} {
    pos(); 
    Col+=yyleng;
    if(strcmp(yytext,"true"))
        yylval.car=1;
        else if(strcmp(yytext,"false")) yylval.car=0;
        else printf("bool type erreur");
    return val_bol;
}
"="   {pos(); Col+=yyleng; return mc_aff;}
"-"   {pos(); Col+=yyleng; return op_sub;}
"+"   {pos(); Col+=yyleng; return op_add;}
"/"   {pos(); Col+=yyleng; return op_div;}
"*"   {pos(); Col+=yyleng; return op_mul;}
","   {pos(); Col+=yyleng; return sep_vg;}
"<"   {pos(); Col+=yyleng; return cmp_l;}
">"   {pos(); Col+=yyleng; return cmp_g;}
"<="  {pos(); Col+=yyleng; return cmp_l_e;}
">="  {pos(); Col+=yyleng; return cmp_g_e;}
"=="  {pos(); Col+=yyleng; return cmp_e;}
"!="  {pos(); Col+=yyleng; return cmp_n_e;}
"["   {pos(); Col+=yyleng; return sep_ob;}
"]"   {pos(); Col+=yyleng; return sep_cb;}
"("   {pos(); Col+=yyleng; return sep_op;}
")"   {pos(); Col+=yyleng; return sep_cp;}
":"   {pos(); Col+=yyleng; return sep_dp;}
" " Col++;
\n Col=1; yylineo++;
{com} {
   pos();
   printf("ceci est une commentaire : \'%s \'\n", yytext);
   Col+=yyleng;}
. {printf("lexical error!\n");}

%%
