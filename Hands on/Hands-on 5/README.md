# Analizador Sintáctico (Flex + Bison)


## Archivos
- lexer.l
- parser.y
- input.c


## Qué reconoce
- Declaraciones globales y locales
- Declaración de funciones
- Bloques `{ ... }`
- Asignaciones
- Llamadas a funciones
- Expresiones aritméticas (+, -, *, /)
- Sentencias: if/else, while, for, return, expresiones terminadas en `;`


## Conjunto de producciones (resumen)
- program -> external_list
- external -> declaration | function_def
- declaration -> type var_list ';'
- function_def -> type ID '(' params ')' compound_stmt
- compound_stmt -> '{' decls stmts '}'
- stmt -> expr_stmt | compound_stmt | selection_stmt | iteration_stmt | return_stmt
- expr -> assignment
- assignment -> ID ASSIGN expr | simple_expr
- simple_expr -> simple_expr PLUS term | simple_expr MINUS term | term
- term -> term MUL factor | term DIV factor | factor
- factor -> NUMBER | ID | ID '(' args ')' | '(' expr ')'


## Cómo compilar
Requisitos: flex, bison, gcc


```bash
flex lexer.l
bison -d parser.y
gcc -o parser parser.tab.c lex.yy.c -lfl

Cómo Ejecutar
./parser input.c

Mensajes de error

El parser imprimirá mensajes de error sintáctico con la línea donde ocurrió el problema.

Limitaciones

Es un subconjunto educativo de C. No hay análisis semántico ni manejo completo de tipos.