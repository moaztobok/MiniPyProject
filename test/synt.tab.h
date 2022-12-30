
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.
   
   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     mc_aff = 258,
     op_sub = 259,
     op_add = 260,
     op_div = 261,
     op_mul = 262,
     cmp_l_e = 263,
     cmp_g_e = 264,
     cmp_l = 265,
     cmp_g = 266,
     cmp_and = 267,
     cmp_or = 268,
     cmp_n_e = 269,
     cmp_e = 270,
     cmp_not = 271,
     sep_vg = 272,
     sep_ob = 273,
     sep_cb = 274,
     sep_op = 275,
     sep_cp = 276,
     sep_dp = 277,
     mc_if = 278,
     mc_else = 279,
     mc_while = 280,
     mc_for = 281,
     mc_in = 282,
     mc_in_range = 283,
     mc_int = 284,
     mc_float = 285,
     mc_car = 286,
     mc_bool = 287,
     idf = 288,
     val_int = 289,
     val_float = 290,
     val_car = 291,
     val_bol = 292
   };
#endif



#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 6 "synt.y"

    int ent;
    float reel;
    char car;
    char *str;



/* Line 1676 of yacc.c  */
#line 98 "synt.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


