%{
   //declaration en C
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void* Pile;
%}

%union{
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

%type <ent><car><reel>VALUE
%type <str>TYPE

%start S

%% 
S : DEC_VAR S | INST S
	
DEC_VAR: TYPE idf LIST_IDF { 
    if(DoubleDecalaration($1,0))
        printf("Erreur semantique double declaration %s",$1);
    else
        insererType($2,$1,0);
    }
    | idf sep_ob val_int sep_cb
    ;
LIST_IDF: sep_vg idf LIST_IDF   { 
    Empiler(Pile,$2);
}
    | sep_vg idf sep_ob val_int sep_cb LIST_IDF
    | {Pile=malloc(sizeof(element));}
    ;
TYPE: mc_int {$$ = $1}
    | mc_char {$$ = $1}
    | mc_float {$$ = $1}
    | mc_bool {$$ = $1}
    ;
VALUE: val_int
    | val_char
    | val_float
    | val_bool
    ;
LIST_INST: INST LIST_INST 
    |
    ;
INST: OP_AFF
    | BLOC_IF
    | BOUCLE
    ;
OP_AFF: idf mc_aff VALUE
    | idf mc_aff idf
    | idf mc_aff OP_ARTH
    ;
OP_ARTH : idf OP_a idf 
    | idf OP_a OP_ARTH
    ;
OP_a : op_add
    | op_div
    | op_sub
    | op_mul
    ;
    
BLOC_IF : mc_if sep_op COND sep_cp sep_dp INST
    | mc_if sep_op COND sep_cp sep_dp INST BLOC_ELSE 
    ;
BLOC_ELSE: mc_else sep_dp INST
COND : idf OP_l idf
    | idf OP_l VALUE
    | idf OP_l idf cmp_and COND
    | idf OP_l idf cmp_or COND
    ;
OP_l : cmp_and
    | cmp_e
    | cmp_g                                          
    | cmp_l
    | cmp_g_e
    | cmp_l_e
    | cmp_n_e
    | cmp_not
    | cmp_or
    ;
//les inst itterative
BOUCLE: mc_while COND sep_dp LIST_INST
    | mc_for idf mc_in_range sep_op val_int sep_vg val_int sep_cp sep_dp LIST_INST
    | mc_for idf mc_in idf sep_dp LIST_INST
    ;
%%