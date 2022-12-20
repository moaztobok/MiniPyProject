%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include "lex.h"
   const FILE *O_lex=fopen("lex.txt","rw+");
   extern yylineo,Col;

%}
com ^#.*
lettreM [A-Z]
lettre [a-zA-Z]
chiffre [0-9]
sep [\[\](),]|(and)|(or)|(not)|(!=)|(==)|(>=)|(<=)
char "|'{lettre}"|'
bool (true)|(false)
IDF {lettreM}({lettre}|{chiffre})*(_{lettre}|{chiffre})*
cstint {chiffre}+
float {chiffre}+\.{chiffre}+
FLT (-{float})|{float}
CST (-{cstint})|{cstint}
%%
"*"   {pos(); rechercher(yytext,"Multiplication","",0,2); Col+=yyleng;	return op_mul;}
"/"   {pos(); rechercher(yytext,"Division","",0,2); Col+=yyleng; return op_div;}
"-"   {pos(); rechercher(yytext,"Soustraction","",0,2); Col+=yyleng; return op_sub;}
"+"   {pos(); rechercher(yytext,"Addition","",0,2); Col+=yyleng; return op_add;}
"="   {pos(); rechercher(yytext,"Affectation","",0,2); Col+=yyleng;	return mc_aff;}
","   {pos(); rechercher(yytext,"virgule","",0,2); Col+=yyleng; return sep_vg;}
"<"   {pos(); rechercher(yytext,"inf","",0,2); Col+=yyleng; return cmp_l;}
">"   {pos(); rechercher(yytext,"sup","",0,2); Col+=yyleng; return cmp_g;}
"<="  {pos(); rechercher(yytext,"inf ou egal","",0,2); Col+=yyleng; return cmp_l_e;}
">="  {pos(); rechercher(yytext,"sup ou egal","",0,2); Col+=yyleng; return cmp_g_e;}
"=="  {pos(); rechercher(yytext,"Egalite","",0,2); Col+=yyleng; return cmp_e;}
"!="  {pos(); rechercher(yytext,"Innegalite","",0,2); Col+=yyleng; return cmp_n_e;}
"["   {pos(); rechercher(yytext,"Crochet Ouvrant","",0,2); Col+=yyleng; return sep_ob;}
"]"   {pos(); rechercher(yytext,"Crochet Fermant","",0,2); Col+=yyleng; return sep_cb;}
"("   {pos(); rechercher(yytext,"Parenthese Ouvrante","",0,2); Col+=yyleng; return sep_op;}
")"   {pos(); rechercher(yytext,"Parenthese Fermante","",0,2); Col+=yyleng; return sep_cp;}
":"   {pos(); rechercher(yytext,"Deux Points","",0,2); Col+=yyleng; return sep_dp;}
{com} {
   pos();
   printf("ceci est une commentaire : \'%s \'\n", yytext);
   Col+=yyleng;}
" " Col++;
\n yylineo++; Col=1;
int {
   pos();
   printf("declaration entier \n"); Col+=yyleng; 
   rechercher(yytext, "Mot Cle","",0,1);
   return mc_int;
}
char {
   pos();
   printf("declaration char \n"); Col+=yyleng; 
   rechercher(yytext, "Mot Cle","",0,1);
   return mc_char;

}

float {
   pos();
   printf("declaration reel \n"); Col+=yyleng;
   rechercher(yytext, "Mot Cle","",0,1);
   return mc_float;
}
bool {
   pos();
   printf("declaration boolean \n"); Col+=yyleng;
   rechercher(yytext, "Mot Cle","",0,1);
   return mc_bool;
}
if {
   pos();
   printf("declaration if \n"); Col+=yyleng;
      rechercher(yytext, "Mot Cle","",0,1);
   return mc_if;
}
else {
   pos();
   printf("declaration else \n"); Col+=yyleng;
      rechercher(yytext, "Mot Cle","",0,1);
   return mc_else;
}
while {
   pos();
   printf("Boucle while \n"); Col+=yyleng;
      rechercher(yytext, "Mot Cle","",0,1);
   return mc_while;
}
for {
   pos();
   printf("Boucle for \n"); Col+=yyleng;
      rechercher(yytext, "Mot Cle","",0,1);
   return mc_for;
}
in {
   pos();
   printf("in \n"); Col+=yyleng;
      rechercher(yytext, "Mot Cle","",0,1);
   return mc_in;
}
in range {
   pos();
   printf("range \n"); Col+=yyleng;
   rechercher(yytext, "Mot Cle","",0,1);
   return mc_in_range;
}
  
{CST} {
   pos();
	Col+=yyleng;
   if ((atoi(yytext)>-32768)&&(atoi(yytext)<32767)){		  
	   printf ("L entite lexicale reconnue est %s \n", yytext);
      rechercher(yytext,"Entier","int",atoi(yytext),0);
      yylval=atoi(yytext);
      return val_int;
	   }else
         printf ("Erreur Lexical: constante entiere trop grande.");
   }
{FLT}   {pos();
	   Col+=yyleng;
      if ((atof(yytext)>-32768)&&(atof(yytext)<32767)){		  
	   printf ("L entite lexicale reconnue est %s \n", yytext);
      rechercher(yytext,"Reel","float",atof(yytext),0);
      yylval=atof(yytext);
      return val_float;
	   }else
         printf ("Erreur Lexical: constante entiere trop grande.");
}
{bool}      {
      pos();
      printf("l'entite %s est un valeur boolean\n", yytext);
      Col+=yyleng;
      if(yytext=="true"){
         rechercher(yytext,"boolean","bool",1,0);
         yylval=1;}
      else{
         rechercher(yytext,"boolean","bool",0,0);
         yylval=0;}
      
      return val_bool;
      }
{char}   { // 'c' yytext[1]
   pos();
   printf("ceci %s est un char\n", yytext);
   rechercher(yytext,"Caractere","char",yytext[1],0);
   yylval=yytext[1];
   Col+=yyleng;
   retrun val_char;
   }
{IDF}    {
   pos(); 
   Col+=yyleng;
   if (yyleng>8){
      printf ("Erreur Lexical: IDF trop long.");
      }else{
         printf (" L entite lexicale reconnue est %s \n", yytext);
         rechercher(yytext,"IDF",0,0);
         yylval=0;}
      return idf;
   }
.  {
   pos();
   printf ("Entite lexicale %s non reconnue\n",yytext);
   Col+=yyleng;
   }
%%
int main() 
{  
   yyin = fopen( "exemple.txt", "r" );
   if (yyin==NULL) printf("ERROR \n");
	else yylex();  
   
   return 0; 
}

