%{


return_stmt:
RETURN ';'
| RETURN expr ';'
;


expr:
assignment
;


assignment:
ID ASSIGN expr
{
Symbol *s = find_in_scope($1);
if (!s)
fprintf(stderr, "Error semántico: Variable '%s' no declarada en línea %d
", $1, yylineno);
}
| simple_expr
;


simple_expr:
simple_expr PLUS term
| simple_expr MINUS term
| term
;


term:
term MUL factor
| term DIV factor
| factor
;


factor:
NUMBER
| ID {
Symbol *s = find_in_scope($1);
if (!s)
fprintf(stderr, "Error semántico: Variable '%s' no declarada en línea %d
", $1, yylineno);
}
| ID '(' args ')' {
Symbol *s = find_in_scope($1);
if (!s || s->type != SYM_FUNC)
fprintf(stderr, "Error semántico: Llamada a función no declarada '%s' en línea %d
", $1, yylineno);
}
| '(' expr ')'
;


args:
| arg_list
;


arg_list:
expr
| arg_list ',' expr
;


%%


int main(int argc, char **argv) {
if (argc > 1) {
FILE *f = fopen(argv[1], "r");
if (!f) { perror("fopen"); return 1; }
yyin = f;
}
yylineno = 1;
if (yyparse() == 0)
printf("Análisis sintáctico y semántico finalizado sin errores.
");
return 0;
}


void yyerror(const char *s) {
fprintf(stderr, "Error sintáctico: %s en línea %d
", s, yylineno);
}