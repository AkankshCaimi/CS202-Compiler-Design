%{

#include <stdio.h>
#include <string.h>
#include <math.h>
int yylex();
void yyerror(char const *);
extern FILE *yyin,*yyout,*lexout;

%}

%token TYPE TYPE_INTEGER TYPE_SINGLE TYPE_DOUBLE TYPE_STRING
%token LET REM PRINT IF THEN ELSE ENDIF INPUT TYPE_DECL END FOR NEXT
%token RETURN STOP GOSUB GOTO DIM DEF FUNC_ID SEMI
%token GREATER_THAN LESS_THAN COMPARE_EQUAL LESS_THAN_EQUAL
%token GREATER_THAN_EQUAL COMPARE_NOT_EQUAL ASSIGN PLUS MINUS DIV MUL EXPO
%union{
    int num;
    char *str;
}
%token <num> NUM
%token <str> ID
%token <str> STRING
%left PLUS MINUS
%left MUL DIV
%left LEFT_BRAC RIGHT_BRAC

%%

programs : program
;

program : var_decl          {fprintf(yyout,"\n");}
    | func_decl             {fprintf(yyout,"\n");}
    | func_def              {fprintf(yyout,"\n");}
    | program var_decl      {fprintf(yyout,"\n");}
    | program func_decl     {fprintf(yyout,"\n");}
    | program func_def      {fprintf(yyout,"\n");}
;

var_decl : int ident SEMI  
    | int ident ASSIGN expr SEMI        {fprintf(yyout,"Assignment : =\n");}
    | char ident SEMI               
    | char ident ASSIGN string SEMI     {fprintf(yyout,"Assignment : =\n");}
;

func_decl : int ident LEFT_BRAC func_args RIGHT_BRAC SEMI           {fprintf(yyout,"Function declared above\n\n");}
    | int ident LEFT_BRAC RIGHT_BRAC SEMI                           {fprintf(yyout,"Function declared above\n\n");}
    | char ident LEFT_BRAC func_args RIGHT_BRAC SEMI                {fprintf(yyout,"Function declared above\n\n");}
    | char ident LEFT_BRAC RIGHT_BRAC SEMI                          {fprintf(yyout,"Function declared above\n\n");}
;

func_def : int ident LEFT_BRAC func_args RIGHT_BRAC func_body       {fprintf(yyout,"Function Defined above\n\n");}
    | int ident LEFT_BRAC RIGHT_BRAC func_body                      {fprintf(yyout,"Function Defined above\n\n");}
    | char ident LEFT_BRAC func_args RIGHT_BRAC func_body           {fprintf(yyout,"Function Defined above\n\n");}
    | char ident LEFT_BRAC RIGHT_BRAC func_body                     {fprintf(yyout,"Function Defined above\n\n");}
;

func_args : int ident                   {fprintf(yyout,"Function Arguments Passed Above\n\n");}
    | int ident COMMA func_args
    | char ident                        {fprintf(yyout,"Function Arguments Passed Above\n\n");}
    | char ident COMMA func_args
;

int : INT       {fprintf(yyout,"Datatype : int\n");}
;

char : CHAR     {fprintf(yyout,"Datatype : char *\n");}
;

func_body : LEFT_CURLY stmt_list RIGHT_CURLY
    | stmt
;

stmt_list : stmt_list stmt
    | stmt
;

stmt : assign_stmt
    | func_call             {fprintf(yyout,"Function call ends \n\n");}
    | return_stmt           {fprintf(yyout,"Return statement \n\n");}
    | condition             {fprintf(yyout,"If Condition Ends \n\n");}
    | loop                  {fprintf(yyout,"While Loop Ends \n\n");}
    | var_decl
;

assign_stmt : expr ASSIGN expr SEMI
;

return_stmt : RETURN SEMI
    | RETURN expr SEMI
;

func_call : ident LEFT_BRAC RIGHT_BRAC SEMI
    | ident LEFT_BRAC expr
;

condition : IF LEFT_BRAC bool RIGHT_BRAC func_body
    | IF LEFT_BRAC bool RIGHT_BRAC func_body ELSE func_body
;

loop : WHILE LEFT_BRAC bool RIGHT_BRAC func_body
;

bool : bool LESS_THAN bool              {fprintf(yyout,"Operator : < \n");}
    | bool GREATER_THAN bool            {fprintf(yyout,"Operator : > \n");}
    | bool COMPARE_EQUAL bool           {fprintf(yyout,"Operator : == \n");}
    | bool COMPARE_NOT_EQUAL bool       {fprintf(yyout,"Operator : != \n");}
    | bool LESS_THAN_EQUAL bool         {fprintf(yyout,"Operator : <= \n");}
    | bool GREATER_THAN_EQUAL bool      {fprintf(yyout,"Operator : >= \n");}
    | expr
;

ident : ID      {fprintf(yyout,"Varibale : %s \n", $1);}
;

number : NUM    {fprintf(yyout,"Value : %d \n", $1);}
;

string : STRING {fprintf(yyout,"Value : %s \n", $1);}
;

expr : LEFT_BRAC expr RIGHT_BRAC
    | expr PLUS expr            {fprintf(yyout,"Operator : + \n");}
    | expr MINUS expr           {fprintf(yyout,"Operator : - \n");}
    | expr MUL expr             {fprintf(yyout,"Operator : * \n");}
    | expr DIV expr             {fprintf(yyout,"Operator : / \n");}
    | number                    
    | ident
;

%%

int main()
{
    yyin=fopen("test.bmm","r");
    yyout=fopen("parser.txt","w");
    lexout=fopen("lexer.txt","w");
    yyparse();
    return 0;
}

void yyerror(char const *s){
    printf("SYNTAX ERROR!\n");
}
