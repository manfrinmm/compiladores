 // Para Executar
 // flex calculadora.l

%{
  #include <stdio.h>
  #include "header.h"
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


"//".*          { } /* Permitir comentários*/

"="             { return '='; } /* Operadores matemáticos */
"*"             { return '*'; } /* Operadores matemáticos */
"^"             { return '^'; } /* Operadores matemáticos */
"/"             { return '/'; } /* Operadores matemáticos */
"-"             { return '-'; } /* Operadores matemáticos */
"+"             { return '+'; } /* Operadores matemáticos */
"("             { return '('; }
")"             { return ')'; }
"{"						  { return '{'; }
"}"						  { return '}'; }


"and"           { return TOKEN_AND; } /* Operadores lógicos */
"or"            { return TOKEN_OR;  } /* Operadores lógicos */


"if"            { return TOKEN_IF;  } /* Operadores lógicos */

"=="						{ return TOKEN_EQUAL; } /* Operadores lógicos */
">"							{ return '>';  } /* Operadores lógicos */
"<"							{ return '<';  } /* Operadores lógicos */
">="						{ return TOKEN_GREATER_THAN_OR_EQUAL; } /* Operadores lógicos */
"<="						{ return TOKEN_LESS_THAN_OR_EQUAL; } /* Operadores lógicos */
"!="						{ return TOKEN_NOT_EQUAL; } /* Operadores lógicos */

{D}+            { yylval.args.intv = atoi(yytext); return TOKEN_INTEGER; } /* Int */
{D}+\.{D}+      { yylval.args.dblv = atof(yytext); return TOKEN_FLOAT;  } /* Float */
{L}({L}|{D})*   { yylval.args.ident = strndup(yytext,yyleng); return TOKEN_IDENT;  } /* Expressões. Outra maneira: [a-zA-Z_][a-zA-Z0-9_] */

.               { printf("Carácter %c não reconhecido.\n", yytext[0]); } /* Carácter não reconhecido */

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
