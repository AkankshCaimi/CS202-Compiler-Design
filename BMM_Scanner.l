%{
    #include <stdio.h>
    #include <string.h>
    #include <math.h>
    #include <stdlib.h>
    #include "y.tab.h"
%}

%%
[\n]                        { fprintf(yyout,"NEW_LINE\n");return NEW_LINE; }
[0-9]+\.[0-9]+              { fprintf(yyout,"FLOAT : %f\n",yylval.flt = atoi(yytext));yylval.flt = atoi(yytext); return FLOAT; }
[0-9]+                      { fprintf(yyout,"INTEGER : %d\n",yylval.num = atoi(yytext));yylval.num = atoi(yytext); return NUM; }
"("                         { fprintf(yyout,"LEFT_BRAC\n");return LEFT_BRAC; }
")"                         { fprintf(yyout,"RIGHT_BRAC\n");return RIGHT_BRAC; }
","                         { fprintf(yyout,"COMMA\n"); return COMMA; }
";"                         { fprintf(yyout,"SEMI\n"); return SEMI; }
\"([^\\\n])*\"              { fprintf(yyout,"STRING: %s\n", yytext); yylval.str = strdup(yytext+1); yylval.str[strlen(yytext)-2] = '\0'; return STRING; }

REM.*                       { fprintf(yyout,"REM\n");return REM;}
"LET"                       { fprintf(yyout,"LET\n");return LET; }
"IF"                        { fprintf(yyout,"IF\n");return IF; }
"THEN"                      { fprintf(yyout,"THEN\n");return THEN; }
"PRINT"                     { fprintf(yyout,"PRINT\n");return PRINT; }
"DATA"                      { fprintf(yyout,"DATA\n");return DATA; }
"INPUT"                     { fprintf(yyout,"INPUT\n");return INPUT; }
"STEP"                      { fprintf(yyout,"STEPn");return STEP; }
"END"                       { fprintf(yyout,"END\n");return END; }
"FOR"                       { fprintf(yyout,"FOR\n");return FOR; }
NEXT.*                      { fprintf(yyout,"NEXT\n");return NEXT; }
"RETURN"                    { fprintf(yyout,"RETURN\n");return RETURN; }
"STOP"                      { fprintf(yyout,"STOP\n");return STOP; }
"GOSUB"                     { fprintf(yyout,"GOSUB\n");return GOSUB; }
"GOTO"                      { fprintf(yyout,"GOTO\n");return GOTO; }
"DIM"                       { fprintf(yyout,"DIM\n");return DIM; }
"DEF"                       { fprintf(yyout,"DEF\n");return DEF; }
"TO"                        { fprintf(yyout,"TO\n");return TO; }
"FN"[A-Z]                   { fprintf(yyout,"FUNCTION ID : %s\n", yytext); yylval.str=strdup(yytext); return FUNC_ID;}

"$"                         { fprintf(yyout,"DOLLAR\n"); return DOLLAR; }
"%"                         { fprintf(yyout,"MODULO\n"); return MODULO; }
"#"                         { fprintf(yyout,"HASH\n"); return HASH; }
"!"                         { fprintf(yyout,"EXCLAMATION\n"); return EXCLAMATION; }
[A-Z][0-9]*                 { fprintf(yyout,"IDENTIFIER\n");yylval.str = strdup(yytext); return IDENTIFIER; }

">"                         { fprintf(yyout,"GREATER_THAN : >\n"); return GREATER_THAN; }
"<"                         { fprintf(yyout,"LESS_THAN : <\n"); return LESS_THAN; }
"=="                        { fprintf(yyout,"COMPARE_EQUAL : ==\n"); return COMPARE_EQUAL; }
"<="                        { fprintf(yyout,"LESS_THAN_EQUAL : <=\n"); return LESS_THAN_EQUAL; }
">="                        { fprintf(yyout,"GREATER_THAN_EQUAL : >=\n"); return GREATER_THAN_EQUAL; }
"<>"                        { fprintf(yyout,"COMPARE_NOT_EQUAL : <>\n"); return COMPARE_NOT_EQUAL; }
"="                         { fprintf(yyout,"ASSIGN : =\n"); return ASSIGN; }
        
"+"                         { fprintf(yyout,"PLUS : +\n"); return PLUS; }
"-"                         { fprintf(yyout,"MINUS : +\n"); return MINUS; }
"/"                         { fprintf(yyout,"DIV : /\n"); return DIV; }
"*"                         { fprintf(yyout,"MUL : *\n"); return MUL; }
"^"                         { fprintf(yyout,"EXPO : ^\n"); return EXPO; }

" "+                        /* SKIP WHITESPACES */
[\t]+                       { fprintf(yyout,"SYNTAX ERROR!\n");}
\.                          { fprintf(yyout,"SYNTAX ERROR!\n");}

%%