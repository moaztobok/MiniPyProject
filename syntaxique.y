%{
   //declaration en C
   
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
%left cmp_l cmp_g cmp_g_e cmp_n_e cmp_l_e
%left sep_or sep_and
%right sep_not
%token <ent>val_int <str>mc_int
%token <car>val_char <str>mc_char
%token <reel>val_float <str>mc_float
%token <str>idf <car>mc_bool
%token op_mul op_div op_sub op_add mc_aff sep_vg sep_ob sep_cb sep_op sep_cp sep_dp
%token cmp_and cmp_or cmp_not cmp_l_e cmp_e cmp_g_e cmp_n_e cmp_l cmp_g
%token mc_if mc_else mc_while mc_for mc_in mc_in_range 
%start S

%% 
S : DEC_VAR S | INST S |
//dec variable
DEC_VAR:  TYPE idf LIST_IDF
          idf VALUE
    |   idf LIST_IDF VALUE
    |   TYPE idf LIST_IDF sep_ob val_int sep_cb 
;  
	
LIST_IDF: sep_vg idf LIST_IDF 
    | 
;
VALUE: val_int
    | val_char
    | val_float
    | ' CHAINE '
      ;
CHAINE: mc_char CHAINE 
    |
      ;
DEC_TAB: TYPE sep_ob val_int sep_cb
;
TYPE: mc_int 
    | mc_char
    | mc_float 
    | mc_bool
      ;
BLOC_INST : INST LIST_INST
      ;
LIST_INST: INST LIST_INST 
    |
      ;
INST : OP_AFF
;
OP_AFF : idf mc_aff VALUE
    |  idf mc_aff idf
    | idf mc_aff OP_ARTH
      ;
OP_ARTH : idf OP_a idf 
    | idf OP_a OP_ARTH
      ;
OP_a :op_add
    |op_div
    |op_sub
    |op_mul
      ;
/*
if (a < b) :
      intruction
else 
      intruction
instruction
*/
//CONDITION
BLOC_IF : mc_if sep_op COND sep_cp sep_dp INST
    | mc_if sep_op COND sep_cp sep_dp INST BLOC_ELSE
    ;
BLOC_ELSE:mc_else sep_dp INST
COND : idf OP_l idf
    | idf OP_l VALUE
    | idf OP_l idf sep_and COND
    | idf OP_l idf sep_or COND
      
OP_l : cmp_and
    |cmp_e
    |cmp_g
    |cmp_l
    |cmp_g_e
    |cmp_l_e
    |cmp_n_e
    |cmp_not
    |cmp_or
      ;
//les inst itterative
BOUCLE : mc_while COND sep_dp INST
      | mc_for idf mc_in_range sep_op val_int sep_vg val_int sep_cp sep_dp  //in range
      | mc_for idf mc_in /*tab*/
%%