%{
    #include<stdlib.h>
    #include<stdio.h>
    #include "synt.tab.h"
    #include "lex.h"
    #include "ts.h"
    #include "synt.h"
    char T_code[20];
    int cmpi=0;
    char qc[20];
    char br[20];
%}

%union {
    int ent;
    double reel;
    char car;
    char *str;
    void *ptr;
}

%right RS
%left  mc_aff cmp_or cmp_and cmp_e cmp_n_e  cmp_g cmp_l cmp_g_e cmp_l_e // '=' ...
%left  op_add op_sub         // '+' '-'
%left  op_mul op_div sep_ob sep_op  // '(' '*' '/' '['
%right cmp_not sep_cb sep_cp       // ')' '!' ']'
%token sep_vg sep_dp 
%token mc_if mc_else mc_while mc_for mc_in mc_in_range
%token <str> mc_int mc_float mc_car mc_bool idf 
%token <ent> val_int
%token <reel> val_float 
%token <car> val_car val_bol
%type <reel> VALUE EXP
%start S
%%

S: DEC_VAR S
    |EXP S 
    |BLOC_IF S
    |BLOC_WHILE S
    |BLOC_FOR S
    |
    ;
DEC_VAR: TYPE LIST_IDF
    ;
LIST_IDF: LIST_IDF sep_vg idf {
        if(find($3,0)){
            Maj($3,"",T_code,0,0,U_code);
            //CreateQuad(qc,$3,"","")
            }
        else
            printf("Entitee <%s> introuvable!\n",$3);
    }
    | idf {
        if(find($1,0)){
            Maj($1,"",T_code,0,0,U_code);
            //CreateQuad(qc,$1,"","")
            }
        else
            printf("Entitee <%s> introuvable!\n",$1);
    }
    | LIST_IDF sep_vg TAB
    | TAB
    ;
TAB: idf sep_ob val_int sep_cb {
        if(find($1,0)){
            Maj($1,"",T_code,0,0,U_code|U_val);//malloc(getsize(T_code)*$3)
            //CreateQuad(Bounds,$3,"","")
            //CreateQuad(ADEC,$1,"","")
            }
        else
            printf("Entitee <%s> introuvable!\n",$1);
    }
    ;
TYPE: mc_int {strcpy(T_code,$1);}
    | mc_float {strcpy(T_code,$1);}
    | mc_car {strcpy(T_code,$1);}
    | mc_bool {strcpy(T_code,$1);}
    ;
EXP: VALUE
    | idf {$$=getval($1);}
    | idf mc_aff EXP {
        if(find($1,0)) Maj($1,"","",$3,0,U_val);
        else printf("Entitee <%s> introuvable!\n",$1);} 
    | EXP op_add EXP {$$ = $1 + $3;}
    | EXP op_sub EXP {$$ = $1 - $3;}
    | EXP op_mul EXP {$$ = $1 * $3;}
    | EXP op_div EXP {if($3!=0) $$ = $1 / $3; else {$$=1; printf("Division par 0 impossible!\n");}}
    | sep_op EXP sep_cp {$$=$2;}
    | EXP cmp_or EXP 
        {$$=($1||$3)?1:0;}
    | EXP cmp_and EXP 
        {$$=($1&&$3)?1:0;}
    | cmp_not EXP 
        {$$=(!$2)?1:0;}
    | EXP cmp_e EXP 
        {$$=($1==$3)?1:0;}
    | EXP cmp_n_e EXP 
        {$$=($1!=$3)?1:0;}
    | EXP cmp_l EXP 
        {$$=($1<$3)?1:0;}
    | EXP cmp_l_e EXP 
        {$$=($1<=$3)?1:0;}
    | EXP cmp_g EXP 
        {$$=($1>$3)?1:0;}
    | EXP cmp_g_e EXP 
        {$$=($1>=$3)?1:0;}
    ;
VALUE: val_float {$$=$1;}
    | val_int {$$=$1;}
    | val_car {$$=(double)$1;}
    | val_bol {$$=$1;}
    ;
BLOC_IF: mc_if sep_op EXP sep_cp sep_dp S %prec RS mc_else sep_dp S {if($3==0){printf("\nFALSE\n");} // if ( EXP ) : 
                                        else{printf("\nTRUE\n");}}
    | mc_if sep_op EXP sep_cp sep_dp {if($3==0){printf("\nFALSE\n");} // if ( EXP ) : 
                                        else{printf("\nTRUE\n");}}
    ;
BLOC_WHILE: mc_while sep_op EXP sep_cp sep_dp  {if($3==0){printf("\n MATBOCLICH \n");} // if ( EXP ) : 
                                        else{printf("\n BLOCKLY\n");}}
    ;
BLOC_FOR:mc_for idf mc_in idf sep_dp
    | mc_for idf mc_in_range idf sep_dp
    ;

%%
int main(){
    yyparse();
    display();
    return 0;
}

