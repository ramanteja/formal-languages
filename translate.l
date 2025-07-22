%{
#include "translate.tab.h"
#include <string.h>
#include <stdlib.h>
char* strdup(const char*);
%}

%%
[a-zA-Z]+  {
              yylval.str = strdup(yytext); 
              return WORD; 
          }
\n         { return EOL; }
.          ; // ignore other characters
%%
