%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

int yylex();
void yyerror(const char *s);
%}

%union {
    int num;
    char* id;
}

%token <num> NUMBER
%token <id> IDENTIFIER
%token SIN COS TAN LOG SQRT
%token POW

%left '+' '-'
%left '*' '/'
%right POW
%left UMINUS

%type <num> exp

%%

input:
    | input line
    ;

line:
    '\n'
    | exp '\n'   { printf("= %d\n", $1); }
    ;

exp:
      NUMBER            { $$ = $1; }
    | exp '+' exp       { $$ = $1 + $3; }
    | exp '-' exp       { $$ = $1 - $3; }
    | exp '*' exp       { $$ = $1 * $3; }
    | exp '/' exp       { $$ = ($3 == 0) ? 0 : $1 / $3; }
    | exp POW exp       { $$ = pow($1, $3); }
    | '-' exp %prec UMINUS { $$ = -$2; }
    | '(' exp ')'       { $$ = $2; }

    | SIN '(' exp ')'   { $$ = sin($3); }
    | COS '(' exp ')'   { $$ = cos($3); }
    | TAN '(' exp ')'   { $$ = tan($3); }
    | LOG '(' exp ')'   { $$ = log($3); }
    | SQRT '(' exp ')'  { $$ = sqrt($3); }

    | IDENTIFIER        { printf("[Identifier used: %s]\n", $1); $$ = 0; free($1); }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter expressions:\n");
    yyparse();
    return 0;
}
