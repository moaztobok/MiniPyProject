%{
   //declaration en C
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lex.h"
#include "ts.h"

void* Pile;
%}

%union {
    int   ent;
    char* str;
    float reel;
    char car;
}


%left mc_aff
%left op_div op_mul 
%left op_add op_sub
%left cmp_e cmp_n_e cmp_l cmp_g cmp_g_e  cmp_l_e
%left cmp_or cmp_and
%right cmp_not
%token <ent>val_int <str>mc_int
%token <car>val_char <str>mc_char
%token <reel>val_float <str>mc_float
%token <str>idf <str>mc_bool <car>val_bool
%token sep_vg sep_ob sep_cb sep_op sep_cp sep_dp       
%token mc_if mc_else mc_while mc_for mc_in mc_in_range

%type <str> TYPE

%start S

%% 
S : DEC_VAR 
	
DEC_VAR: TYPE idf { 
    if(DoubleDecalaration($1,0))
        printf("Erreur semantique double declaration %s",$1);
    else
        insererType($2,$1,0);
    }
    | idf sep_ob val_int sep_cb
    ;
TYPE: mc_int {$$ = $1}
    | mc_char {$$ = $1}
    | mc_float {$$ = $1}
    | mc_bool {$$ = $1}
    ;
    %%

