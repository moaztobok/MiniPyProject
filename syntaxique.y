%{
   //declaration en C
   
   %}*
//les lois de grammaire 
%union{
         int   ent;
         char* str;
         float reel;
         char car;
}
%left mc_aff
%left  op_div op_mul op_add op_sub
%left sep_or sep_and 
%left cmp_l cmp_g cmp_g_e cmp_n_e cmp_l_e
%token <ent>val_int <str>mc_int
%token <car>val_char <str>mc_char
%token <reel>val_float <str>mc_float
%token <str>idf 
%token op_mul op_div op_sub op_add aff sep_vg sep_ob spe_cb sep_op sep_cp 
%token cmp_and cmp_or cmp_not cmp_l_e cmp_e cmp_g_e cmp_n_e cmp_l cmp_g <car>mc_bool
%token mc_if mc_else mc_while mc_for mc_in mc_in_range  
%start S

%% 
S : DEC_VAR S | INST S |
//dec variable
DEC_VAR:  TYPE idf LIST_IDF
          idf VALUE
      |   TYPE idf LIST_IDF sep_ob val_int sep_cb 
;  
	
LIST_IDF: sep_vg idf LIST_IDF 
        | 
;
VALUE: ent
       char
       CHAINE
;
CHAINE: char CHAINE    
      | {

      }
      ;
DEC_TAB: TYPE Bar_L int Bar_R
;
TYPE: mc_int 
      | mc_char
      | mc_flaot 
      | mc_bool
      ;
%%