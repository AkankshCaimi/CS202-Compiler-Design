%{
    #include <stdio.h>
    #include <string.h>
    #include <math.h>
    #include "bminus.tab.h"
    FILE *lex out_put;
%}

%%
[\n][0-9]{1,4}              { fprintf(lex_output,"NEW_LINE\n");return NEW_LINE; }
[0-9]+/.[0-9]+              { fprintf(lex_output,"FLOAT : %f\n",yylval.num = atoi(yytext));yylval.num = atoi(yytext); return FLOAT; }
[0-9]+                      { fprintf(lex_output,"INTEGER : %d\n",yylval.num = atoi(yytext));yylval.num = atoi(yytext); return NUM; }

[\(]                        { fprintf(lex_output,"LEFT_BRAC\n");return LEFT_BRAC; }
[\)]                        { fprintf(lex_output,"RIGHT_BRAC\n");return RIGHT_BRAC; }
","                         { fprintf(lex_output,"COMMA\n"); return COMMA; }
";"                         { fprintf(lex_output,"SEMI\n"); return SEMI; }
(\"[a-zA-Z0-9]*\")          { fprintf(lex_output,"TYPE : STRING"); yylval.str=strdup(yytext); return STRING;}

"REM".*                     { fprintf(lex_output,"COMMENTS\n");/* ignore comments */ }
"LET"                       { fprintf(lex_output,"LET\n");return LET; }
"IF"                        { fprintf(lex_output,"IF\n");return IF; }
"THEN"                      { fprintf(lex_output,"THEN\n");return THEN; }
"ELSE"                      { fprintf(lex_output,"ELSE\n");return ELSE; }
"ENDIF"                     { fprintf(lex_output,"ENDIF\n");return ENDIF; }
"PRINT"                     { fprintf(lex_output,"PRINT\n");return PRINT; }
"INPUT"                     { fprintf(lex_output,"INPUT\n");return INPUT; }
"TYPE"                      { fprintf(lex_output,"TYPE_DECL\n");return TYPE_DECL; }
"END"                       { fprintf(lex_output,"END\n");return END; }
"FOR"                       { fprintf(lex_output,"FOR\n");return FOR; }
"NEXT"                      { fprintf(lex_output,"NEXT\n");return NEXT; }
"RETURN"                    { fprintf(lex_output,"RETURN\n");return RETURN; }
"STOP"                      { fprintf(lex_output,"STOP\n");return STOP; }
"GOSUB"                     { fprintf(lex_output,"GOSUB\n");return GOSUB; }
"GOTO"                      { fprintf(lex_output,"GOTO\n");return GOTO; }
"DIM"                       { fprintf(lex_output,"DIM\n");return DIM; }
"DEF"                       { fprintf(lex_output,"DEF\n");return DEF; }
[F][N][A-Z]                 { fprintf(lex_output,"FUNCTION ID : %s\n", yytext); yylval.str=strdup(yytext); return FUNC_ID;}


[A-Z][0-9]?\$               { fprintf(lex_output,"TYPE : STRING\n");yylval.id = *yytext; yylval.type = TYPE_STRING; return ID; }
[A-Z][0-9]?\#               { fprintf(lex_output,"TYPE : DOUBLE\n");yylval.id = *yytext; yylval.type = TYPE_DOUBLE; return ID; }
[A-Z][0-9]?\%?              { fprintf(lex_output,"TYPE : INTEGER\n");yylval.id = *yytext; yylval.type = TYPE_INTEGER; return ID; }
[A-Z][0-9]?\!               { fprintf(lex_output,"TYPE : SINGLE\n");yylval.id = *yytext; yylval.type = TYPE_SINGLE; return ID; }
">"                         { fprintf(lex_output,"GREATER_THAN : >\n"); return GREATER_THAN; }
"<"                         { fprintf(lex_output,"LESS_THAN : <\n"); return LESS_THAN; }
"=="                        { fprintf(lex_output,"COMPARE_EQUAL : ==\n"); return COMPARE_EQUAL; }
"<="                        { fprintf(lex_output,"LESS_THAN_EQUAL : <=\n"); return LESS_THAN_EQUAL; }
">="                        { fprintf(lex_output,"GREATER_THAN_EQUAL : >=\n"); return GREATER_THAN_EQUAL; }
"<>"                        { fprintf(lex_output,"COMPARE_NOT_EQUAL : <>\n"); return COMPARE_NOT_EQUAL; }
"="                         { fprintf(lex_output,"ASSIGN : =\n"); return ASSIGN; }
        
"+"                         { fprintf(lex_output,"PLUS : +\n"); return PLUS; }
"-"                         { fprintf(lex_output,"MINUS : +\n"); return MINUS; }
"/"                         { fprintf(lex_output,"DIV : /\n"); return DIV; }
"*"                         { fprintf(lex_output,"MUL : *\n"); return MUL; }
"^"                         { fprintf(lex_output,"EXPO : ^\n"); return EXPO; }


[\t]+                       { fprintf(lex_output,"SYNTAX ERROR\n");yyerror("SYNTAX ERROR! (Tab detected!, Invalid)"); }
.                           { fprintf(lex_output,"SYNTAX ERROR\n");yyerror("SYNTAX ERROR! (Invalid character)"); }

%%
int yy wrap(){
    return 1;
}

