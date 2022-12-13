%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include "lex.h"
//   int yylineo=1; //compter le nombre de ligne
//   int Col=1; //nombre de colonne
//   void pos(){
//      printf("%d,%d  ",yyline,Col);}
%}
com ^#.*
lettreM [A-Z]
lettre [a-zA-Z]
chiffre[0-9]
sep [\-\*\.\+\[\]<>\(\)/,=]|(and)|(or)|(not)|(!=)|(==)|(>=)|(<=)
char {lettre}
bool (true)|(false)
IDF {lettreM}({lettre}|{chiffre})*(_{lettre}|{chiffre})*
cstint {chiffre}+
float {chiffre}+\.{chiffre}+
negfloat \(-{float}\)
negint \(-{cstint}\)
%%

{sep} {
   pos();
   printf("separateur: %s \n", yytext);
   Col+=yyleng;
}

{com} {
   pos();
   printf("ceci est une commentaire : \'%s \'\n", yytext);
   Col+=yyleng;}
" " Col++;
\n yylineo++; Col=1;
int {
   pos();
   printf("declaration entier \n"); Col+=yyleng;
}
char {
   pos();
   printf("declaration char \n"); Col+=yyleng;
}

reel {
   pos();
   printf("declaration reel \n"); Col+=yyleng;
}
bool {
   pos();
   printf("declaration boolean \n"); Col+=yyleng;
}
if {
   pos();
   printf("declaration if \n"); Col+=yyleng;
}
else {
   pos();
   printf("declaration else \n"); Col+=yyleng;
}
while {
   pos();
   printf("Boucle while \n"); Col+=yyleng;
}
for {
   pos();
   printf("Boucle for \n"); Col+=yyleng;
}
case {
   pos();
   printf("condition Switch case \n"); Col+=yyleng;
}
in {
   pos();
   printf("in \n"); Col+=yyleng;
}
range {
   pos();
   printf("range \n"); Col+=yyleng;
}

{cstint} {
   pos();
   if ((atoi(yytext)>-32768)&&(atoi(yytext)<32767)){		  
	   printf ("L entite lexicale reconnue est %s \n", yytext);
	   }else
         printf ("Erreur Lexical: constante entiere trop grande a la ligne %d a la colonne %d \n ",yylineo, Col);
	Col+=yyleng;}
{negint}	{
            pos();
				printf("l'entite entree %s est un entier negative\n",yytext);
            Col+=yyleng;
			 }
{negfloat}   {
            pos();
            printf("this  is a negfloat %s \n",yytext);
            Col+=yyleng;
}
{float}     {
   pos();
   printf("this is a float %s \n",yytext);
   Col+=yyleng;
}
{bool}      {
      pos();
      printf("l'entite %s est un valeur boolean\n", yytext);
      Col+=yyleng;
      }
{char}      {
   pos();
   printf("ceci %s est un char\n", yytext);
   Col+=yyleng;
   }
{IDF}    {
         pos(); 
         if (yyleng>8) printf ("Erreur Lexical: IDF trop long a la ligne %d a la colonne %d \n ",yylineo, Col);
            else {printf (" L entite lexicale reconnue est %s \n", yytext);}
         Col+=yyleng;
		  }
. {pos();
   printf ("Entite lexicale %s non reconnue\n",yytext);
   Col+=yyleng;}
%%
int main() 
{  
   yyin = fopen( "exemple.txt", "r" );
   if (yyin==NULL) printf("ERROR \n");
	else yylex();  
   
   return 0; 
}

