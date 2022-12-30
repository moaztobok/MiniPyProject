#ifndef LEX_H
#define LEX_H

#include<stdio.h>
#include<stdlib.h>

int yylineo=1; //compter le nombre de ligne
int Col=1; //nombre de colonne

void pos(){
	printf("%d,%d  ",yylineo,Col);
}

#endif
