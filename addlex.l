%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "add.tab.h"
%}

digit     [0-9]+
id        [a-zA-Z_][a-zA-Z0-9_]*

%%

{digit}       { yylval.num = atoi(yytext); return NUMBER; }
"sin"         { return SIN; }
"cos"         { return COS; }
"tan"         { return TAN; }
"log"         { return LOG; }
"sqrt"        { return SQRT; }
{id}          { yylval.id = strdup(yytext); return IDENTIFIER; }

"^"           { return POW; }
"+"           { return '+'; }
"-"           { return '-'; }
"*"           { return '*'; }
"/"           { return '/'; }
"("           { return '('; }
")"           { return ')'; }
"\n"          { return '\n'; }
[ \t]+        ; // ignore whitespace
.             { printf("Unknown character: %s\n", yytext); }

%%
