%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
int yylex();
#include "symbol.h"
void yyerror(char const *);
extern FILE *yyin,*yyout,*lex_tokkens;
%}

%token <num> NUM 
%toekn <str> ID 
%token <str> STRING
%token TYPE TYPE_INTEGER TYPE_SINGLE TYPE_DOUBLE TYPE_STRING
%token LET REM PRINT IF THEN ELSE ENDIF INPUT TYPE_DECL END FOR NEXT
%token RETURN STOP GOSUB GOTO DIM DEF FUNC_ID
%token ID GREATER_THAN LESS_THAN COMPARE_EQUAL LESS_THAN_EQUAL
%token GREATER_THAN_EQUAL COMPARE_NOT_EQUAL ASSIGN PLUS MINUS DIV MUL EXPO


%left PLUS MINUS
%left '*' '/'
%nonassoc '<' '>' '='

%%
program : statements END
        {
            /* execute statements */
        }
        ;

statements : stmt
           | statements stmt
           ;

stmt : LET ID ASSIGN expr SEMI
    {
        set_value($2, $4);
        free_expr($4);
    }
    | REM
    {
        free_stmt($1);
    }
    | PRINT expr ';'
    {
        print_value($2);
        free_expr($2);
    }
    | IF condition THEN statements ELSE statements ENDIF
    {
        free_condition($2);
        free_stmt_list($4);
        free_stmt_list($6);
    }
    | INPUT ID ';'
    {
        /* read input from user */
    }
    | TYPE_DECL ID TYPE ';'
    {
        if ($3 == TYPE_INTEGER) {
            set_type($2, TYPE_INTEGER);
        } else if ($3 == TYPE_SINGLE) {
            set_type($2, TYPE_SINGLE);
        } else if ($3 == TYPE_DOUBLE) {
            set_type($2, TYPE_DOUBLE);
        } else if ($3 == TYPE_STRING) {
            set_type($2, TYPE_STRING);
        }
    }
    ;

condition : expr '<' expr
          | expr '>' expr
          | expr '=' expr
          ;

expr : term
     | expr '+' term
     {
         $$ = create_expr(EXPR_OP, OP_ADD, $1, $3);
     }
     | expr '-' term
     {
         $$ = create_expr(EXPR_OP, OP_SUB, $1, $3);
     }
     ;

term : factor
     | term '*' factor
     {
         $$ = create_expr(EXPR_OP, OP_MUL, $1, $3);
     }
     | term '/' factor
     {
         $$ = create_expr(EXPR_OP, OP_DIV, $1, $3);
     }
     ;

factor : NUM
       {
           $$ = create_expr(EXPR_NUM, $1, NULL, NULL);
       }
       | ID
       {
           $$ = create_expr(EXPR_VAR, 0, $1, NULL);
       }
       | ID '(' expr_list ')'
       {
           /* function call */
       }
       | '(' expr ')'
       {
           $$ = $2;
       }
       ;

expr_list : expr
          | expr_list ',' expr
          ;

%%
int yylex() {
    int c = getchar();

    /* skip whitespace */
    while (c == ' ' || c == '\n') {
        c = getchar();
    }

    /* handle numbers */
    if (isdigit(c)) {
        ungetc(c, stdin);
        scanf("%d", &yylval.num);
        return NUM;
    }

    /* handle keywords and operators */
    if (isalpha(c) || c == '%') {
        char buffer[1024];
        int i = 0;
        buffer[i++] = c;
        c = getchar();

        while (isalpha(c) || isdigit(c) || c == '$' || c == '#' || c == '!') {
            buffer[i++] = c;
            c = getchar();
        }

        buffer[i] = '\0';
        ungetc(c, stdin);

        if (strcmp(buffer, "LET") == 0) {
            return LET;
        } else if (strcmp(buffer, "REM") == 0) {
            return REM;
        } else if (strcmp(buffer, "PRINT") == 0) {
            return PRINT;
        } else if (strcmp(buffer, "IF") == 0) {
            return IF;
        } else if (strcmp(buffer, "THEN") == 0) {
            return THEN;
        } else if (strcmp(buffer, "ELSE") == 0) {
            return ELSE;
        } else if (strcmp(buffer, "ENDIF") == 0) {
            return ENDIF;
        } else if (strcmp(buffer, "INPUT") == 0) {
            return INPUT;
        } else if (strcmp(buffer, "TYPE") == 0) {
            return TYPE_DECL;
        } else if (strcmp(buffer, "END") == 0) {
            return END;
        } else if (buffer[1] == '\0' || buffer[2] != '\0' || !isdigit(buffer[1])) {
            yylval.id = *buffer;
            return ID;
        } else {
            int len = strlen(buffer);
            char type = buffer[len - 1];
            yylval.id = buffer[0];

            if (type == '%') {
                yylval.type = TYPE_INTEGER;
            } else if (type == '!') {
                yylval.type = TYPE_SINGLE;
            } else if (type == '#') {
                yylval.type = TYPE_DOUBLE;
            } else if (type == '$') {
                yylval.type = TYPE_STRING;
            }   else {
                yylval.id = *buffer;
                return ID;
            }
        }
    }
}
int main(){
    yyin=fopen("test.bmm","r");
    yyout=fopen("parser.txt","w");
    lexout=fopen("lexer.txt","w");
    yyparse();
    return 0;
}

void yyerror(char const *s){
    printf("Syntax Error\n");
}
