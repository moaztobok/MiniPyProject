%{
    #include<stdlib.h>
    #include<stdio.h>
    #include "synt.tab.h"
    #include "lex.h"
    #include "ts.h"
    #include "synt.h"
%}

%union {
    int ent;
    float reel;
    char car;
    char *str;
}

%left  mc_aff
%left  op_add op_sub
%left  op_mul op_div
%left  cmp_e cmp_n_e cmp_or cmp_and cmp_g cmp_l cmp_g_e cmp_l_e 
%right cmp_not 
%token sep_vg sep_ob sep_cb sep_op sep_cp sep_dp 
%token mc_if mc_else mc_while mc_for mc_in mc_in_range 
%token <str> mc_int mc_float mc_car mc_bool idf 
%token <ent> val_int
%token <reel> val_float 
%token <car> val_car val_bol
%nterm <str> TYPE
%nterm <reel> VALUE 

%start S

%%
S   : /*empty*/
    | DEC_VAR S
    ;      
DEC_VAR: TYPE idf {
    if(find($2,0))
        Maj($2,"",$1,0,0,U_code);
    else
        printf("idf <%s> undeclared\n.",$2);
}
    ;
TYPE: mc_int
    | mc_float
    | mc_car
    | mc_bool
    ;

VALUE: val_int 
    | val_float
    | val_car  
    | val_bol  
    ;
/*
INST : OP_AFF
    | BLOC_IF
    ;
OP_AFF: idf mc_aff VALUE
    | idf mc_aff idf
    | idf mc_aff OP_ARTH
    ;
OP_ARTH : idf op_add idf  {}
    |     idf op_sub idf  {printf("sous");}
    |     idf op_div idf  {printf("div");}
    |     idf op_mul idf  {printf("mul");}
    ;
BLOC_IF : mc_if sep_op COND sep_cp sep_dp INST {printf("if bloc");}
    | mc_if sep_op COND sep_cp sep_dp INST BLOC_ELSE {printf("if else bloc");}
    ;
BLOC_ELSE: mc_else sep_dp INST
    ;
BLOC_WHILE : mc_while sep_ob COND sep_dp INST
    ;
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
    */

%%
int main(){
    yyparse();
    display();
    return 0;
}

