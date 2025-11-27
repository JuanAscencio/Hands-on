%{
/*
  lexer.l - Analizador léxico para un subconjunto de C
  Reconoce: palabras reservadas, identificadores, literales numéricos,
  operadores, delimitadores y comentarios (/* ... * / , // ...).
  Imprime: línea, token y lexema.
*/

#include <stdio.h>
#include <string.h>

int yylex(void);
extern int yylineno;
%}

%option noyywrap
%option yylineno

/* Definiciones: uso de clases POSIX para evitar rangos con '-' */
DIGIT      [0-9]
ID_START   [[:alpha:]_]
ID_CONT    [[:alnum:]_]
INTEGER    {DIGIT}+
FLOAT      {DIGIT}+"."{DIGIT}+
IDENT      {ID_START}{ID_CONT}*

%%

/* ----------------- Comentarios ----------------- */
/\/\*([^*]|\*+[^*/])*\*+\/          { /* comentario multilínea */ ;
                                     /* incrementado automático de yylineno por %option yylineno
                                        si hay saltos de línea en el comentario. */ }

/\/\/[^\n]*                         { /* comentario hasta fin de línea */ ; }

/* ----------------- Espacios en blanco ----------------- */
[ \t\r]+                           { /* ignorar espacios y tabuladores */ ; }
\n+                                { /* ignorar nueva línea(s) — yylineno ya incrementado */ ; }

/* ----------------- Preprocesador / include / define ----------------- */
/\#[[:space:]]*include              { printf("LINE %d\tTOKEN %-20s\t\"#include\"\n", yylineno, "PREPROCESSOR"); }
/\#[[:space:]]*define               { printf("LINE %d\tTOKEN %-20s\t\"#define\"\n", yylineno, "PREPROCESSOR"); }

/* reconocer la palabra include o define también si aparece sola */
\<include\>                         { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "KW_INCLUDE", yytext); }
\<define\>                          { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "KW_DEFINE", yytext); }

/* ----------------- Palabras reservadas (tipos y return) ----------------- */
\<int\>                             { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "KW_INT", yytext); }
\<float\>                           { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "KW_FLOAT", yytext); }
\<double\>                          { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "KW_DOUBLE", yytext); }
\<char\>                            { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "KW_CHAR", yytext); }
\<void\>                            { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "KW_VOID", yytext); }
\<short\>                           { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "KW_SHORT", yytext); }
\<return\>                          { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "KW_RETURN", yytext); }

/* ----------------- Literales numéricos ----------------- */
{FLOAT}                             { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "LITERAL_FLOAT", yytext); }
{INTEGER}                           { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "LITERAL_INT", yytext); }

/* ----------------- Identificadores (variables, funciones, macros, etc.) ----------------- */
{IDENT}                             { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "IDENTIFIER", yytext); }

/* ----------------- Operadores (priorizar los multi-char) ----------------- */
"++"                                { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "OP_INC", yytext); }
"--"                                { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "OP_DEC", yytext); }
"+="                                { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "OP_PLUSEQ", yytext); }
"-="                                { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "OP_MINUSEQ", yytext); }
"=="                                { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "OP_EQ", yytext); }
"="                                 { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "OP_ASSIGN", yytext); }
"+"                                 { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "OP_PLUS", yytext); }
"-"                                 { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "OP_MINUS", yytext); }
"*"                                 { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "OP_MUL", yytext); }
"/"                                 { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "OP_DIV", yytext); }

/* ----------------- Delimitadores y puntuación ----------------- */
"("                                 { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "LPAREN", yytext); }
")"                                 { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "RPAREN", yytext); }
"{"                                 { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "LBRACE", yytext); }
"}"                                 { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "RBRACE", yytext); }
";"                                 { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "SEMICOLON", yytext); }
","                                 { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "COMMA", yytext); }
"<"                                 { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "LT", yytext); }
">"                                 { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "GT", yytext); }

/* Cualquier otro caracter imprimible (para debug) */
.                                   { printf("LINE %d\tTOKEN %-20s\t\"%s\"\n", yylineno, "UNKNOWN", yytext); }

%%

int main(int argc, char **argv) {
    if (argc > 1) {
        FILE *f = fopen(argv[1], "r");
        if (!f) {
            perror("fopen");
            return 1;
        }
        yyin = f;
    }
    yylex();
    return 0;
}
