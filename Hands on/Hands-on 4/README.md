# Analizador Léxico en Flex — Subconjunto de C

## Integrantes
- Juan José Ascencio Tapia

---

## Descripción General

Este proyecto implementa un **analizador léxico** utilizando **Flex**, capaz de identificar los elementos fundamentales de un subconjunto del lenguaje C a partir de un flujo de caracteres. El análisis léxico constituye la primera etapa del proceso de compilación, encargada de convertir una secuencia de caracteres en una secuencia de **tokens**.

El analizador reconoce:

### • Palabras reservadas
`int`, `float`, `double`, `char`, `void`, `short`, `return`, `include`, `define`

### • Identificadores
Nombres válidos de variables, funciones, macros y librerías.  
Se reconocen con la regla:  
Letra o guion bajo inicial, seguido de letras, dígitos o guion bajo.

### • Literales numéricos
- Enteros (ej. `2`, `15`, `300`)
- Números flotantes (ej. `3.14`, `0.25`)

### • Operadores
`+`, `-`, `*`, `/`, `=`, `==`, `++`, `--`, `+=`, `-=`  

### • Delimitadores
`(` `)` `{` `}` `;` `,` `<` `>`

### • Comentarios
- Multilínea: `/* ... */`
- Una línea: `// ...`

### • Otros
Cualquier otro carácter no reconocido se clasifica como `UNKNOWN`.

El analizador imprime por pantalla **el número de línea**, el **tipo de token** y el **lexema** correspondiente.

---

## Estructura del Proyecto

El repositorio contiene:

- `lexer.l`  
  Archivo principal escrito en Flex que define las reglas del analizador.

- `input.c`  
  Programa en C que sirve como entrada de prueba para el lexer.

- `README.md`  
  Documento con instrucciones, compilación y descripción del analizador.

---

## Requisitos

Para compilar y ejecutar el analizador se requieren:

- **Flex**  
- **gcc** (o cualquier compilador C compatible)
- Librería `-lfl` (se instala junto con Flex en la mayoría de distros)

---

## Instrucciones de Compilación

1. Generar el archivo fuente C a partir del archivo Flex:


flex lexer.l
Esto generará el archivo:

lex.yy.c
Compilar el analizador léxico:


gcc lex.yy.c -lfl -o lexer
Nota: En algunos sistemas no es necesario -lfl.
En ese caso basta con:
gcc lex.yy.c -o lexer

Ejecución del Analizador
Ejecuta el programa pasando como entrada un archivo .c:


./lexer input.c
O mediante redirección:


./lexer < input.c
El programa imprimirá líneas como:

nginx
LINE 1    TOKEN PREPROCESSOR         "#include"
LINE 1    TOKEN LT                   "<"
LINE 1    TOKEN IDENTIFIER           "stdlib.h"
LINE 1    TOKEN GT                   ">"
LINE 2    TOKEN PREPROCESSOR         "#define"
LINE 2    TOKEN IDENTIFIER           "SCALE_FACTOR"
LINE 2    TOKEN LITERAL_INT          "2"
...
Capacidades y Limitaciones
Capacidades
Reconoce el subconjunto solicitado del lenguaje C.

Maneja correctamente comentarios multilínea y de línea simple.

Imprime tokens de forma clara y con el número de línea.

No usa rangos con el símbolo - en expresiones regulares (usa clases POSIX).

Limitaciones
No maneja cadenas ("texto") ni literales de carácter ('a').

No reconoce notación científica para números (1e10).

No analiza sufijos de literales numéricos.

No valida semántica (solo tokens, no errores del lenguaje).

Posibles Extensiones
Estas mejoras se pueden implementar fácilmente:

Agregar reconocimiento de cadenas y caracteres.

Aceptar números reales con notación exponencial.

Exportar tokens en formato JSON o CSV.

Integración con un analizador sintáctico (por ejemplo con Bison).

Licencia
Proyecto académico sin fines comerciales.

