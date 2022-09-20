 // Para Executar -> Esse é o código do analisador léxico (gramática)
 // flex calculadora.l

%{
  #include <stdio.h>
  #include "header.h"

  int yyerror (const char *s);
  int yylex (void);

  extern int yylineno;
%}

%union {
    struct node *node;
}

%define parse.error verbose

%token TOKEN_IDENT TOKEN_PRINT TOKEN_INTEGER TOKEN_FLOAT 
%token TOKEN_LITERAL TOKEN_EQUAL TOKEN_MULTIPLY TOKEN_DIVIDE 
%token TOKEN_MINUS TOKEN_PLUS TOKEN_OP TOKEN_CP

%type <node> program stmts stmt assignment arithmetic term term2 factor

%start program


%%

 // $n -> Sendo `n` o parâmetro de entrada do analisador léxico

program : stmts {
          node *program = create_node (PROGRAM, 1);
          program -> children[0] = $1;

          // Chamada da árvore abstrata
          // Chamada da verificação semântica
          // Chamada da geração de código
        }
        ;

stmts : stmt stmts {
          $$ = create_node (STMT, 2);
          $$ -> children[0] = $1;
          $$ -> children[1] = $2;
      }  
      | stmt {
          $$ = create_node (STMT, 1);
          $$ -> children[0] = $1;
      }
      ;
      
stmt : assignment {
          $$ = create_node (GENERIC, 1);
          $$ -> children[0] = $1;
     }
     | TOKEN_PRINT arithmetic { 
          $$ = create_node (PRINT, 1);
          $$ -> children[0] = $2;
     }
     ;

assignment : TOKEN_IDENT '=' arithmetic { 
               $$ = create_node (ASSIGN, 2);
               $$ -> children[0] = create_node (IDENT, 0);
               $$ -> children[0] -> name = NULL;
               $$ -> children[1] = $3;
           }
           ;

arithmetic : arithmetic '+' term { 
               $$ = create_node (SUM, 2);
               $$ -> children[0] = $1;
               $$ -> children[1] = $3;
           }    
           | arithmetic '-' term { 
               $$ = create_node (MINUS, 2);
               $$ -> children[0] = $1;
               $$ -> children[1] = $3;
           }    
           | term {
               $$ = create_node (GENERIC, 1);
               $$ -> children[0] = $1;
           }
           ;

term : term '*' term2 { 
          $$ = create_node (MULTIPLY, 2);
          $$ -> children[0] = $1;
          $$ -> children[1] = $3;
     }
     | term '/' term2 { 
          $$ = create_node (DIVIDE, 2);
          $$ -> children[0] = $1;
          $$ -> children[1] = $3;
     } 
     | term2 {
          $$ = create_node (GENERIC, 1);
          $$ -> children[0] = $1;
     }
     ;

term2 : term2 '^' factor { 
          $$ = create_node (POW, 2);
          $$ -> children[0] = $1;
          $$ -> children[1] = $3;
     }
     | factor {
          $$ = create_node (GENERIC, 1);
          $$ -> children[0] = $1;
     }
     ;

factor : '(' arithmetic ')' { 
          $$ = create_node (PARENT, 1);
          $$ -> children[0] = $2;
       }
       | TOKEN_IDENT {
          $$ = create_node (IDENT, 0);
          $$ -> name = NULL;
       }
       | TOKEN_INTEGER  {
          $$ = create_node (INTEGER, 0);
          $$ -> value = 0;
       }
       | TOKEN_FLOAT {
          $$ = create_node (FLOAT, 0);
          $$ -> value = 0;
       }
       ;

%%

int yyerror (const char *s) {
     printf("Erro na linha %d: %s\n", yylineno, s);
	return 1;
}
