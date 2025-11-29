%{
/* empty */
| declaration
| expr_stmt
;


for_cond:
/* empty */
| expr
;


for_inc:
/* empty */
| expr
;


return_stmt:
RETURN ';'
| RETURN expr ';'
;


expr:
assignment
;


assignment:
ID ASSIGN expr { /* asignación */ }
| simple_expr
;


simple_expr:
simple_expr PLUS term { /* suma */ }
| simple_expr MINUS term { /* resta */ }
| term
;


term:
term MUL factor { /* multiplicación */ }
| term DIV factor { /* división */ }
| factor
;


factor:
NUMBER
| ID
| ID '(' args ')'
| '(' expr ')'
;


args:
/* empty */
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
yylineno = 1; col = 1;
if (yyparse() == 0) printf("Parsing finalizado sin errores.
");
return 0;
}


void yyerror(const char *s) {
fprintf(stderr, "Error sintáctico: %s en línea %d
", s, yylineno);
}