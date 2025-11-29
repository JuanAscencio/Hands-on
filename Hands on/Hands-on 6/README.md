# Análisis Semántico con Tablas de Símbolos y Scopes


## Objetivo
Extender el analizador sintáctico para agregar análisis semántico mediante:
- Tabla de símbolos
- Manejo de scopes
- Validación de variables y funciones


## Validaciones implementadas
- Uso de variables no declaradas (local y global)
- Redeclaración de variables
- Redeclaración de funciones
- Número de parámetros almacenado para validaciones posteriores
- Pila de scopes en bloques `{}` y funciones


## Estructuras utilizadas
- `Symbol` → representa variables y funciones
- `SymbolTable` → tabla asociada a un scope
- `ScopeStack` → pila de scopes


## Archivos incluidos
- `lexer.l` → analizador léxico
- `parser.y` → análisis sintáctico + semántico
- `input.c` → archivo de prueba


## Cómo compilar
```bash
flex lexer.l
bison -d parser.y
gcc parser.tab.c lex.yy.c -o analizador -lfl

Cómo ejecutar
./analizador input.c

Mensajes de error semántico

El sistema identifica:

Variables usadas sin declarar

Redeclaraciones en el mismo scope

Llamadas a funciones no declaradas

Limitaciones

No valida tipos

No valida número exacto de parámetros en llamadas (solo registra)

Subconjunto educativo de C


