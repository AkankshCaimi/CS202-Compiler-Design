%{

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include "y.tab.h"


int yylex();
void yyerror(char const *);
extern FILE *yyin,*yyout;

int previous=-1;
void yyerror(const char *str)
{
     fprintf(stderr,"error: %s\n",str);
}

int yywrap()
{
     return 1;
}
int main()
{
     yyin=fopen("IncorrectSample.bmm","r"); yyout=fopen("output.txt","w");
     yyparse();

     return 0;
}

%}

%token LET REM PRINT IF THEN INPUT END FOR NEXT
%token RETURN STOP GOSUB GOTO DIM DEF SEMI NEW_LINE FUNC_ID
%token GREATER_THAN LESS_THAN COMPARE_EQUAL LESS_THAN_EQUAL DATA COMMA
%token GREATER_THAN_EQUAL COMPARE_NOT_EQUAL ASSIGN PLUS MINUS DIV MUL EXPO
%token IDENTIFIER HASH MODULO DOLLAR EXCLAMATION TO STEP
%union{
    int num;
    char *str;
    float flt;
    char chr;
}
%token <num> NUM
%token <str> STRING
%token <flt> FLOAT

%left PLUS MINUS
%left MUL DIV
%left LEFT_BRAC RIGHT_BRAC

%%

programs : program;

program : statements | statements program;

statements : NUM statement NEW_LINE
           { 
            if(previous>=$1)
               yyerror("LINE ERROR!\n"), exit(1);
            previous=$1;
           }

statement : data | def| dim| for
          | gosub| goto| if| let
          | input| print| rem
          | return| next| END {fprintf(yyout, "ENDED\n");exit(0);}
          | STOP {fprintf(yyout,"STOPPED\n");exit(0);}
;

data  : DATA v_l;

v_l : v_l COMMA value | value;

value : NUM | FLOAT | STRING;

def : DEF FUNC_ID LEFT_BRAC IDENTIFIER RIGHT_BRAC ASSIGN expr
    | DEF FUNC_ID ASSIGN expr
    | DEF FUNC_ID LEFT_BRAC RIGHT_BRAC ASSIGN expr;

expr : LEFT_BRAC expr RIGHT_BRAC
    | expr PLUS expr          
    | expr MINUS expr         
    | expr MUL expr           
    | expr DIV expr   
    | expr EXPO expr        
    | identy
    | NUM | FLOAT | STRING
;

for : FOR IDENTIFIER ASSIGN expr TO expr STEP expr 
    | FOR IDENTIFIER ASSIGN expr TO expr;

goto : GOTO NUM;

gosub : GOSUB NUM;

if : IF condition THEN NUM;

condition : expr LESS_THAN expr
          | expr LESS_THAN_EQUAL expr
          | expr COMPARE_EQUAL expr
          | expr GREATER_THAN expr
          | expr ASSIGN expr
          | expr GREATER_THAN_EQUAL expr;

let : LET identx ASSIGN expr;

input : INPUT i_l;

i_l : i_l COMMA i_v|i_v;

i_v : identx LEFT_BRAC NUM RIGHT_BRAC
    | identx LEFT_BRAC identx RIGHT_BRAC
    | identx;

identy : identx LEFT_BRAC NUM RIGHT_BRAC
       | identx LEFT_BRAC identx RIGHT_BRAC
       | identx;

identx : IDENTIFIER DOLLAR | IDENTIFIER | IDENTIFIER EXCLAMATION 
       | IDENTIFIER HASH | IDENTIFIER MODULO;

rem : REM words | REM;
next : NEXT words | NEXT;

dim : DIM dim_list;

dim_list: dim_d | dim_list COMMA dim_d;

dim_d : IDENTIFIER LEFT_BRAC NUM COMMA NUM RIGHT_BRAC | IDENTIFIER LEFT_BRAC NUM RIGHT_BRAC;

print : PRINT p_l SEMI | PRINT p_l COMMA | PRINT p_l;

p_l : p_t | p_l COMMA p_t | p_l SEMI p_t;

p_t : NUM | STRING | LEFT_BRAC expr RIGHT_BRAC | IDENTIFIER;

words : words IDENTIFIER | IDENTIFIER;

return : RETURN;
%%