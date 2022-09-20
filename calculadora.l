 // Para Executar
 // flex calculadora.l

%{
  #include <stdio.h>
  #include "calculadora.tab.h"
%}

%option yylineno

/* Números */ 
D  [0-9] 
/* Declaração de variáveis */ 
L  [a-zA-Z_] 

%%
[ \t\r\n]       {} /* Joga espaços fora */
"print"         { return TOKEN_PRINT; } /* Saída de dados */

{D}             { return TOKEN_INTEGER; } /* Int */
{D}+\.{D}+      { return TOKEN_FLOAT;  } /* Float */
{L}({L}|{D})*   { return TOKEN_LITERAL;  } /* Expressões. Outra maneira: [a-zA-Z_][a-zA-Z0-9_] */

"="             { return '='; } /* Operadores matemáticos */
"*"             { return '*'; } /* Operadores matemáticos */
"/"             { return '/'; } /* Operadores matemáticos */
"-"             { return '-'; } /* Operadores matemáticos */
"+"             { return '+'; } /* Operadores matemáticos */
"("             { return '('; } /* Operadores matemáticos */
")"             { return ')'; } /* Operadores matemáticos */

.            { printf("Character %c not recognized.\n", yytext[0]); } /* Carácter não reconhecido */
%%

int yywrap() {
  return 1;
}

int main(int argc, char *argv[]) {
  if(argc <= 1){
    printf("%s [file]\n", argv[0]);
    
    return 1;
  }

  FILE *f = fopen(argv[1], "r");
  
  yyin = f;
  yyparse();

  fclose(f);

  return 0;
}
