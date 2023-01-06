%{
    #include<string.h>
    #include<stdlib.h>
    #include<stdio.h>
    #include "synt.tab.h"
    #include "lex.h"
    #include "ts.h"
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
    addNode(yytext,"Mot Cle","",0,2);
    yylval.str=strdup(yytext);
    return mc_int;
}
float {
    pos(); 
    addNode(yytext,"Mot Cle","",0,2);
    Col+=yyleng;
    yylval.str=strdup(yytext);
    return mc_float;
}
char {
    pos();
    addNode(yytext,"Mot Cle","",0,2);
    Col+=yyleng;
    yylval.str=strdup(yytext);
    return mc_car;
}
bool {
    pos(); 
    Col+=yyleng;
    addNode(yytext,"Mot Cle","",0,2);
    printf("declaration boolean \n"); Col+=yyleng;
    yylval.str=strdup(yytext);
   return mc_bool;
}
if {
   pos();
   printf("Bloq_con_if \n"); Col+=yyleng;
    addNode(yytext,"Mot Cle","",0,2);
   return mc_if;
}
else {
   pos();
   printf("declaration else \n"); Col+=yyleng;
    addNode(yytext,"Mot Cle","",0,2);
      
   return mc_else;
}
while {
   pos();
   printf("Boucle while \n"); Col+=yyleng;
    addNode(yytext,"Mot Cle","",0,2);
     
   return mc_while;
}
for {
   pos();
   printf("Boucle for \n"); Col+=yyleng;
    addNode(yytext,"Mot Cle","",0,2);
      
   return mc_for;
}
in {
   pos();
   printf("in \n"); Col+=yyleng;
    addNode(yytext,"Mot Cle","",0,2);
    
   return mc_in;
}
"in range" {
   pos();
   printf("range \n"); Col+=yyleng;
    addNode(yytext,"Mot Cle","",0,2);
   return mc_in_range;
}
{IDF}   {
    pos();
    Col+=yyleng;
    if(yyleng<8){
        addNode(yytext,"IDF","",0,0);
        yylval.str=strdup(yytext);
        return idf;
    }else
        printf("idf trop long!\n");
}
{CST}   {
    pos();
    Col+=yyleng;
    if(atoi(yytext)<=32768 && atoi(yytext)>=-32768){
        addNode(yytext,"Entier","int",atof(yytext),0);
        yylval.ent=atoi(yytext);
        return val_int;
    }else
        printf("entier trop long!\n");
}
{FLT}   {
    pos(); 
    Col+=yyleng;
    if(atof(yytext)<=32768 && atof(yytext)>=-32768){
        addNode(yytext,"Reel","float",atof(yytext),0);
        yylval.reel=atof(yytext);
        return val_float;
    }else
        printf("reel trop long!\n");
}
{char} {
    pos();
    Col+=yyleng;
    addNode(yytext,"Caractere","char",yytext[1],0);
    yylval.car=yytext[1];
    return val_car; 
}
{bool} {
    pos(); 
    Col+=yyleng;
    if(!strcmp(yytext,"true")){
        addNode(yytext,"Booleen","bool",1,0);
        yylval.car=1;
    }else{
        addNode(yytext,"Booleen","bool",0,0);
        yylval.car=0;}
    return val_bol;
}

"="     {pos(); Col+=yyleng; addNode(yytext,"Affect","",0,1); return mc_aff;}
"-"     {pos(); Col+=yyleng; addNode(yytext,"Soustraction","",0,1); return op_sub;}
"+"     {pos(); Col+=yyleng; addNode(yytext,"Addition","",0,1); return op_add;}
"/"     {pos(); Col+=yyleng; addNode(yytext,"Division","",0,1); return op_div;}
"*"     {pos(); Col+=yyleng; addNode(yytext,"Multiplication","",0,1); return op_mul;}
","     {pos(); Col+=yyleng; addNode(yytext,"Virgule","",0,1); return sep_vg;}
"<"     {pos(); Col+=yyleng; addNode(yytext,"INF","",0,1); return cmp_l;}
">"     {pos(); Col+=yyleng; addNode(yytext,"SUP","",0,1); return cmp_g;}
"<="    {pos(); Col+=yyleng; addNode(yytext,"INF_EG","",0,1); return cmp_l_e;}
">="    {pos(); Col+=yyleng; addNode(yytext,"SUP_EG","",0,1); return cmp_g_e;}
"=="    {pos(); Col+=yyleng; addNode(yytext,"Egalitee","",0,1); return cmp_e;}
"!="    {pos(); Col+=yyleng; addNode(yytext,"Inegalitee","",0,1); return cmp_n_e;}
"["     {pos(); Col+=yyleng; addNode(yytext,"Crch ouvr","",0,1); return sep_ob;}
"]"     {pos(); Col+=yyleng; addNode(yytext,"Crch ferm","",0,1); return sep_cb;}
"("     {pos(); Col+=yyleng; addNode(yytext,"Par ouvr","",0,1); return sep_op;}
")"     {pos(); Col+=yyleng; addNode(yytext,"Par ferm","",0,1); return sep_cp;}
":"     {pos(); Col+=yyleng; addNode(yytext,"Deux pts","",0,1); return sep_dp;}
" "     {Col++;}
\n      {Col=1; yylineo++;}
{com} {
   pos();
   Col+=yyleng;}

. {pos(); printf("lexical error!\n");}

%%
