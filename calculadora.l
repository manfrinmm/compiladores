 // Para Executar
 // flex calculadora.l

%{
  #include <stdio.h>
%}

%option yylineno

/* Números */ 
D  [0-9] 
/* Declaração de variáveis */ 
L  [a-zA-Z_] 

%%
[ \t\r\n]       {} /* Joga espaços fora */
"print"         { printf("TOKEN_PRINT\n"); } /* Saída de dados */

{D}             { printf("TOKEN_INTEGER <%s>\n", yytext); } /* Int */
{D}+\.{D}+      { printf("TOKEN_FLOAT <%s>\n", yytext); } /* Float */
{L}({L}|{D})*   { printf("TOKEN_LITERAL <%s>\n", yytext); } /* Expressões. Outra maneira: [a-zA-Z_][a-zA-Z0-9_] */

"="             { printf("TOKEN_EQUAL\n"); } /* Operadores matemáticos */
"*"             { printf("TOKEN_MULTIPLY\n"); } /* Operadores matemáticos */
"/"             { printf("TOKEN_DIVIDE\n"); } /* Operadores matemáticos */
"-"             { printf("TOKEN_MINUS\n"); } /* Operadores matemáticos */
"+"             { printf("TOKEN_PLUS\n"); } /* Operadores matemáticos */
"("             { printf("TOKEN_OP\n"); } /* Operadores matemáticos */
")"             { printf("TOKEN_CP\n"); } /* Operadores matemáticos */

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
  yylex();

  fclose(f);

  return 0;
}
