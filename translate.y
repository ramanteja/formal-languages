%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);

typedef struct {
    char* en;
    char* other;
} WordMap;

WordMap dict[] = {
    {"hello", "cześć"},
    {"world", "świat"},
    {"dog", "pies"},
    {"cat", "kot"},
    {"food", "jedzenie"},
    {"friend", "przyjaciel"},
    {NULL, NULL}
};

void translate(const char* input) {
    for (int i = 0; dict[i].en != NULL; ++i) {
        if (strcmp(input, dict[i].en) == 0) {
            printf("→ %s\n", dict[i].other);
            return;
        }
        if (strcmp(input, dict[i].other) == 0) {
            printf("→ %s\n", dict[i].en);
            return;
        }
    }
    printf("→ [not found]\n");
}
%}

%union {
    char* str;
}

%token <str> WORD
%token EOL
%type <str> word

%%
input:
    | input line
    ;

line:
    word EOL  { translate($1); free($1); }
    ;

word:
    WORD { $$ = $1; }
    ;
%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter words to translate (Ctrl+D to exit):\n");
    yyparse();
    return 0;
}