%{
    #include<stdlib.h>
    #include<stdio.h>
    #include "synt.tab.h"
    #include "lex.h"
    #include "ts.h"
    #include "synt.h"

    char T_code[20];
%}

%union {
    int ent;
    double reel;
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
%type <car> Cond
%type <reel> VALUE EXP
%start S
%%

S: DEC_VAR S
    | Cond S
    | EXP S
    |
    ;
DEC_VAR: TYPE LIST_IDF
    ;
LIST_IDF: LIST_IDF sep_vg idf {
        if(find($3,0))
            Maj($3,"",T_code,0,0,U_code);
        else
            printf("Entitee <%s> introuvable!\n",$3);
    }
    | idf {
        if(find($1,0))
            Maj($1,"",T_code,0,0,U_code);
        else
            printf("Entitee <%s> introuvable!\n",$1);
    }
    | LIST_IDF sep_vg TAB
    | TAB
    ;
TAB: idf sep_ob val_int sep_cb {
        if(find($1,0))
            Maj($1,"",T_code,0,0,U_code|U_val);//malloc(getsize(T_code)*$3)
        else
            printf("Entitee <%s> introuvable!\n",$1);
    }
    ;
TYPE: mc_int {strcpy(T_code,$1);}
    | mc_float {strcpy(T_code,$1);}
    | mc_car {strcpy(T_code,$1);}
    | mc_bool {strcpy(T_code,$1);}
    ;
//
Cond:
    val_bol {
        if($1) $$=1; else $$=0; }
    | idf {$$=getBool($1);}
    | Cond cmp_or Cond 
        {if($1||$3)$$=1; else $$=0;}
    | Cond cmp_and Cond 
        {if($1&&$3)$$=1; else $$=0;}
    | cmp_not Cond 
        {if(!$2)$$=1; else $$=0;}
    | Cond cmp_e Cond 
        {if($1==$3)$$=1; else $$=0;}
    | Cond cmp_n_e Cond 
        {if($1!=$3)$$=1; else $$=0;}
    | Cond cmp_l Cond 
        {if($1<$3)$$=1; else $$=0;}
    | Cond cmp_l_e Cond 
        {if($1<=$3)$$=1; else $$=0;}
    | Cond cmp_g Cond 
        {if($1>$3)$$=1; else $$=0;}
    | Cond cmp_g_e Cond 
        {if($1>=$3)$$=1; else $$=0;}
    ;
EXP: idf mc_aff VALUE {
        if(find($1,0))
            Maj($1,"","",$3,0,U_val);
        else
            printf("Entitee <%s> introuvable!\n",$1);
    }
    |idf mc_aff EXP 
    | VALUE
    | idf {$$=getval($1);}
    | EXP op_add EXP {$$ = $1 + $3;}
    | sep_op EXP sep_cp {$$=$2;}
    ;
VALUE: val_float {$$=$1;}
    | val_int {$$=$1;}
    | val_car {$$=(double)$1;}
    | val_bol {$$=$1;}
    ;
%%
int main(){
    yyparse();
    display();
    return 0;
}

