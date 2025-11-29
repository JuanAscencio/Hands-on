%{
#include "parser.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


int col = 1;
extern int yylineno;


#define UPDATE_COL() (col += yyleng)


void yyerror(const char *s);
%}


%%
[
]+ { UPDATE_COL(); }


{ yylineno++; col = 1; }
"//"[^
]* { /* comentario de línea */ }
"/\*"([^*]|\*+[^*/])*"\*/" { /* comentario multilínea simple */ const char *p = yytext; for (; *p; ++p) if (*p=='
') yylineno++; col = 1; }


"int" { UPDATE_COL(); return INT; }
"void" { UPDATE_COL(); return VOID; }
"return" { UPDATE_COL(); return RETURN; }
"if" { UPDATE_COL(); return IF; }
"else" { UPDATE_COL(); return ELSE; }
"while" { UPDATE_COL(); return WHILE; }
"for" { UPDATE_COL(); return FOR; }


"[0-9]+" { yylval.ival = atoi(yytext); UPDATE_COL(); return NUMBER; }
"[A-Za-z_][A-Za-z0-9_]*" { yylval.sval = strdup(yytext); UPDATE_COL(); return ID; }


";" { UPDATE_COL(); return ';'; }"," { UPDATE_COL(); return ','; }
"=" { UPDATE_COL(); return ASSIGN; }
"\+" { UPDATE_COL(); return PLUS; }
"-" { UPDATE_COL(); return MINUS; }
"\*" { UPDATE_COL(); return MUL; }
"/" { UPDATE_COL(); return DIV; }
"\(" { UPDATE_COL(); return '('; }
"\)" { UPDATE_COL(); return ')'; }
"\{" { UPDATE_COL(); return '{'; }
"\}" { UPDATE_COL(); return '}'; }


. { fprintf(stderr, "Carácter no reconocido '%s' en línea %d columna %d
", yytext, yylineno, col); UPDATE_COL(); }


%%


int yywrap(void) { return 1; }


void yyerror(const char *s) {
fprintf(stderr, "Error léxico: %s en línea %d, columna %d
", s, yylineno, col);
}