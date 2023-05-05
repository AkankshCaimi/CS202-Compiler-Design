%{
    #include <stdio.h>
    #include <string.h>
    #include <math.h>
    FILE *lex_tokkens;
    #include "bminus.tab.h"
%}

%%
[\n][0-9]{1-4}              { fprintf (lex_tokkens,"NEW_LINE\n");return NEW_LINE; }
[-]?[0-9]+                  { fprintf (lex_tokkens,"INTEGER : %d\n",yylval.num = atoi(yytext));yylval.num = atoi(yytext); return NUM; }
[\(]                        { fprintf (lex_tokkens,"LEFT_BRAC\n");return LEFT_BRAC; }
[\)]                        { fprintf (lex_tokkens,"RIGHT_BRAC\n");return RIGHT_BRAC; }
","                         { fprintf (lex_tokkens,"COMMA\n"); return COMMA; }
";"                         { fprintf (lex_tokkens,"SEMI\n"); return SEMI; }
(\"[a-zA-Z0-9]*\")          { fprintf (lex_tokkens, "TYPE : string"); yylval.str=strdup(yytext); return STRING;}

"REM".*                     { fprintf (lex_tokkens,"COMMENTS\n");/* ignore comments */ }
"LET"                       { fprintf (lex_tokkens,"LET\n");return LET; }
"IF"                        { fprintf (lex_tokkens,"IF\n");return IF; }
"THEN"                      { fprintf (lex_tokkens,"THEN\n");return THEN; }
"ELSE"                      { fprintf (lex_tokkens,"ELSE\n");return ELSE; }
"ENDIF"                     { fprintf (lex_tokkens,"ENDIF\n");return ENDIF; }
"PRINT"                     { fprintf (lex_tokkens,"PRINT\n");return PRINT; }
"INPUT"                     { fprintf (lex_tokkens,"INPUT\n");return INPUT; }
"TYPE"                      { fprintf (lex_tokkens,"TYPE_DECL\n");return TYPE_DECL; }
"END"                       { fprintf (lex_tokkens,"END\n");return END; }
"FOR"                       { fprintf (lex_tokkens,"FOR\n");return FOR; }
"NEXT"                      { fprintf (lex_tokkens,"NEXT\n");return NEXT; }
"RETURN"                    { fprintf (lex_tokkens,"RETURN\n");return RETURN; }
"STOP"                      { fprintf (lex_tokkens,"STOP\n");return STOP; }
"GOSUB"                     { fprintf (lex_tokkens,"GOSUB\n");return GOSUB; }
"GOTO"                      { fprintf (lex_tokkens,"GOTO\n");return GOTO; }
"DIM"                       { fprintf (lex_tokkens,"DIM\n");return DIM; }
"DEF"                       { fprintf (lex_tokkens,"DEF\n");return DEF; }
[F][N][A-Z]                 { fprintf (lex_tokkens,"FUNCTION ID : %s\n", yytext); yylval.str=strdup(yytext); return FUNC_ID;}


[A-Z]\$?                    { yylval.id = *yytext; return ID; }
[A-Z][0-9]?\$?              { yylval.id = *yytext; return ID; }
[A-Z]\#                     { yylval.id = *yytext; yylval.type = TYPE_DOUBLE; return ID; }
[A-Z]\%                     { yylval.id = *yytext; yylval.type = TYPE_INTEGER; return ID; }
[A-Z]\!                     { yylval.id = *yytext; yylval.type = TYPE_SINGLE; return ID; }
">"                         { fprintf (lex_tokkens,"GREATER_THAN : >\n"); return GREATER_THAN; }
"<"                         { fprintf (lex_tokkens,"LESS_THAN : <\n"); return LESS_THAN; }
"=="                        { fprintf (lex_tokkens,"COMPARE_EQUAL : ==\n"); return COMPARE_EQUAL; }
"<="                        { fprintf (lex_tokkens,"LESS_THAN_EQUAL : <=\n"); return LESS_THAN_EQUAL; }
">="                        { fprintf (lex_tokkens,"GREATER_THAN_EQUAL : >=\n"); return GREATER_THAN_EQUAL; }
"<>"                        { fprintf (lex_tokkens,"COMPARE_NOT_EQUAL : <>\n"); return COMPARE_NOT_EQUAL; }
"="                         { fprintf (lex_tokkens,"ASSIGN : =\n"); return ASSIGN; }
        
"+"                         { fprintf (lex_tokkens,"PLUS : +\n"); return PLUS; }
"-"                         { fprintf (lex_tokkens,"MINUS : +\n"); return MINUS; }
"/"                         { fprintf (lex_tokkens,"DIV : /\n"); return DIV; }
"*"                         { fprintf (lex_tokkens,"MUL : *\n"); return MUL; }
"^"                         { fprintf (lex_tokkens,"EXPO : ^\n"); return EXPO; }


[\t]+                       { yyerror("SYNTEX ERROR! (Tab detected!, Invalid)"); }
.                           { yyerror("SYNTEX ERROR! (Invalid character)"); }

%%

int yywrap() {
    return 1;
}
