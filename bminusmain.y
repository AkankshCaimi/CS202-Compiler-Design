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
%union{
    int num;
    char *str;
    float flt;
    struct expr* e;

}
%token  NUM 
%token  FLOAT
%token  ID 
%token  STRING
%token TYPE TYPE_INTEGER TYPE_SINGLE TYPE_DOUBLE TYPE_STRING
%token LET REM PRINT IF THEN ELSE ENDIF INPUT TYPE_DECL END FOR NEXT
%token RETURN STOP GOSUB GOTO DIM DEF FUNC_ID SEMI COMMA NEW_LINE
%token GREATER_THAN LESS_THAN COMPARE_EQUAL LESS_THAN_EQUAL COMMENT
%token GREATER_THAN_EQUAL COMPARE_NOT_EQUAL ASSIGN PLUS MINUS DIV MUL EXPO

%left PLUS MINUS
%left MUL DIV
%left LEFT_BRAC RIGHT_BRAC

%nonassoc LESS_THAN GREATER_THAN ASSIGN

%%
program : statements END

statements : stmt
           | stmt statements
           
stmt : NUM LET ID ASSIGN expr SEMI NEW_LINE
     | NUM REM capital NEW_LINE
     | NUM PRINT expr SEMI NEW_LINE
     | NUM IF condition THEN statements NEW_LINE
     | NUM INPUT in NEW_LINE
     | NUM DEF 
     | NUM GOTO NUM
     | NUM RETURN


     | TYPE_DECL ID TYPE SEMI
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

in : ID | ID SEMI in

capital : COMMENT
        | COMMENT capital

condition : expr LESS_THAN expr
          | expr GREATER_THAN expr
          | expr ASSIGN expr
          ;

expr : term
     | expr PLUS term
     {
         $$ = create_expr(EXPR_OP, OP_ADD, $1, $3);
     }
     | expr MINUS term
     {
         $$ = create_expr(EXPR_OP, OP_SUB, $1, $3);
     }
     ;

term : factor
     | term MUL factor
     {
         $$ = create_expr(EXPR_OP, OP_MUL, $1, $3);
     }
     | term DIV factor
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
       | ID LEFT_BRAC expr_list RIGHT_BRAC
       {
           /* function call */
       }
       | LEFT_BRAC expr RIGHT_BRAC
       {
           $$ = $2;
       }
       ;

expr_list : expr
          | expr_list COMMA expr
          ;

%%
int yylex() {
    int c = getchar();

    /* skip whitespace */
    while (c == ' ') {
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
    printf("SYNTEX ERROR\n");
}
