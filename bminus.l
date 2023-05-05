%{
    #include <stdio.h>
    #include <string.h>
    #include <math.h>
    FILE *lex_tokkens;
    #include "bminus.tab.h"
%}

%%
[\n][0-9]{1-4}              { fprintf (lex_tokkens,"NEW_LINE\n");return NEW_LINE; }
"REM".*                     { fprintf (lex_tokkens,"COMMENTS\n");/* ignore comments */ }
[0-9]+                      { fprintf (lex_tokkens,"INTEGER : %d\n",yylval.num = atoi(yytext));yylval.num = atoi(yytext); return NUM; }
[\(]                        { fprintf (lex_tokkens,"LEFT_BRAC\n");return LEFT_BRAC; }
[\)]                        { fprintf (lex_tokkens,"RIGHT_BRAC\n");return RIGHT_BRAC; }
","                         { fprintf (lex_tokkens,"COMMA\n"); return COMMA; }
";"                         { fprintf (lex_tokkens,"SEMI\n"); return SEMI; }

"LET"                       { fprintf (lex_tokkens,"LET\n");return LET; }
"IF"                        { fprintf (lex_tokkens,"IF\n");return IF; }
"THEN"                      { fprintf (lex_tokkens,"THEN\n");return THEN; }
"ELSE"                      { fprintf (lex_tokkens,"ELSE\n");return ELSE; }
"ENDIF"                     { fprintf (lex_tokkens,"ENDIF\n");return ENDIF; }
"PRINT"                     { fprintf (lex_tokkens,"PRINT\n");return PRINT; }
"INPUT"                     { fprintf (lex_tokkens,"INPUT\n");return INPUT; }
"TYPE"                      { fprintf (lex_tokkens,"TYPE_DECL\n");return TYPE_DECL; }
"END"                       { fprintf (lex_tokkens,"END\n");return END; }

[A-Z]\$?                    { yylval.id = *yytext; return ID; }
[A-Z][0-9]\$?               { yylval.id = *yytext; return ID; }
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
[\t]+                       { yyerror("Tab detected!, Invalid"); }
.                           { yyerror("Invalid character"); }

%%

int yywrap() {
    return 1;
}
