%{
#include "bminus.tab.h"
%}

%%
[ \t\n]+                    /* ignore whitespace */
"REM".*                     { /* ignore comments */ }
[0-9]+                      { yylval.num = atoi(yytext); return NUM; }
[+\-*/=<>]                  { return *yytext; }
"("                         { return '('; }
")"                         { return ')'; }
";"                         { return ';'; }
":"                         { return ':'; }
","                         { return ','; }
"LET"                       { return LET; }
"IF"                        { return IF; }
"THEN"                      { return THEN; }
"ELSE"                      { return ELSE; }
"ENDIF"                     { return ENDIF; }
"PRINT"                     { return PRINT; }
"INPUT"                     { return INPUT; }
"TYPE"                      { return TYPE_DECL; }
"END"                       { return END; }

[A-Z]\$?                    { yylval.id = *yytext; return ID; }
[A-Z][0-9]\$?               { yylval.id = *yytext; return ID; }
[A-Z]\#                    { yylval.id = *yytext; yylval.type = TYPE_DOUBLE; return ID; }
[A-Z]\%                    { yylval.id = *yytext; yylval.type = TYPE_INTEGER; return ID; }
[A-Z]\!                    { yylval.id = *yytext; yylval.type = TYPE_SINGLE; return ID; }
"=="                        { return EQ; }
">="                        { return GE; }
"<="                        { return LE; }
"!="                        { return NE; }
"="                         { return '='; }
">"                         { return '>'; }
"<"                         { return '<'; }
"-"                         { return '-'; }
"+"                         { return '+'; }
"*"                         { return '*'; }
"/"                         { return '/'; }
.                           { yyerror("Invalid character"); }

%%

int yywrap() {
    return 1;
}
