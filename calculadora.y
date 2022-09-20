 // Para Executar
 // flex calculadora.l

%{
  #include <stdio.h>

  int yyerror (const char *s);
  int yylex (void);

  extern int yylineno;
%}

%define parse.error verbose

%token TOKEN_IDENT TOKEN_PRINT TOKEN_INTEGER TOKEN_FLOAT 
%token TOKEN_LITERAL TOKEN_EQUAL TOKEN_MULTIPLY TOKEN_DIVIDE 
%token TOKEN_MINUS TOKEN_PLUS TOKEN_OP TOKEN_CP

%start program

%%

program : stmts {}
        ;

stmts : stmt stmts  
      | stmt
      ;
      
stmt : assignment
     | TOKEN_PRINT arithmetic
     ;

assignment : TOKEN_IDENT '=' arithmetic
           ;

arithmetic : arithmetic '+' term
           | arithmetic '-' term
           | term
           ;

term : term '*' term2
     | term '/' term2 
     | term2 
     ;

term2 : term2 '^' factor
     | factor 
     ;

factor : '(' arithmetic ')'
       | TOKEN_IDENT
       | TOKEN_INTEGER
       | TOKEN_FLOAT
       ;

%%

int yyerror (const char *s) {
     printf("Erro na linha %d: %s\n", yylineno, s);
	return 1;
}
