#ifndef LEX_H
#define LEX_H

#include<stdio.h>
#include<stdlib.h>

static int yylineo=1; //compter le nombre de ligne
static int Col=1; //nombre de colonne

static void pos(){
	printf("%d,%d  ",yylineo,Col);
}

#endif
