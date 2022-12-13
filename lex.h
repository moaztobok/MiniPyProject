#ifndef _LEX_H
#define _LEX_H

    #include<stdio.h>

    int yylineo=1; //compter le nombre de ligne
    int Col=1; //nombre de colonne
  
  
    void pos(){
      printf("%d,%d  ",yylineo,Col);}
#endif
