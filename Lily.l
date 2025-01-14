%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"

int line_number = 1;
%}

%option yylineno

alpha [a-zA-Z]
digit [0-9]
unary "++"|"--"

%%

"program"                 { return PROGRAM; }
"const"                   { return CONST ;}
"var"                     { return VAR;}

")"                 { return CLOSED_PARENTHESIS; }
"("                   { return OPEN_PARENTHESIS ;}

"}"                 { return CLOSED_CURLY; }
"{"                   { return OPEN_CURLY ;}

"integer"                 { return INT; }
"reel"                    { return FLOAT; }
"char"                    { return CHAR; }
"string"                  { return STRING; }

"record"                  { return RECORD; }
"end"                     { return END; }
"begin"                   { return BEGIN_T; }
"if"                      { return IF; }
"then"                    { return THEN; }
"endif"                   { return ENDIF; }
"else"                    { return ELSE; }
"repeter"                 { return REPETER; }
"Jusqu'a"               { return JUSQUA; }


[-]?{digit}+                { return NUMBER; }
[-]?{digit}+\.{digit}{1,6}  { return FLOAT_NUM; }

{alpha}                { return LETTRE;}

{alpha}({alpha}|{digit})*   { return IDENTIFIER; }

"E+"                    { return EXPONENT; }
"E-"                    { return EXPONENT; }

":"                     { return COLUMN; }
","                     { return COMMA; }

"="                    { return ASSIGN;}

"+"                     { return ADD_OP; }
"*"                     { return MULTIPLY_OP; }
"-"                     { return SUBTRACT_OP; }
"/"                     { return DIVIDE_OP;}


";"                     { return SEMI_COLUMN;}
"."                     { return DOT;}
"_"                     { return UNDER_SCORE;}

"<"                     { return LOGICAL_OPERATOR; }
">"                     { return LOGICAL_OPERATOR; }
">="                    { return LOGICAL_OPERATOR;}
"<="                    { return LOGICAL_OPERATOR;}
"<>"                    { return LOGICAL_OPERATOR; }
"=="                     { return LOGICAL_OPERATOR; }
['].[']                     { return STRING_LITERAL; }
["]["]                     { return VIDE; }

[ \t]+                  {;}
\n                      { line_number++; }


%%

int yywrap() {
    return 1;
}
