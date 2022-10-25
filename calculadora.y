 // Para Executar -> Esse é o código do analisador léxico (gramática)
 // flex calculadora.l

%{
  #include <stdio.h>
  #include <stdlib.h>
  #include "header.h"

  int yyerror (const char *s);
  int yylex (void);

  extern int yylineno;
%}

%union {  
    token_args args;
    struct node *node;
}

%define parse.error verbose

%token <args> TOKEN_IDENT TOKEN_FLOAT TOKEN_INTEGER
%token TOKEN_PRINT TOKEN_OR TOKEN_AND TOKEN_IF TOKEN_EQUAL TOKEN_GREATER_THAN_OR_EQUAL TOKEN_LESS_THAN_OR_EQUAL TOKEN_NOT_EQUAL

%type <node> program stmts stmt assignment arithmetic term term2 factor
%type <node> if logicalFactor logicalExpression logicalExpressionTerm

%start program

%%

program : stmts {
          node *program = create_node (PROGRAM, 1);
          program -> children[0] = $1;

          // Chamada da árvore abstrata
      	print(program);
          // Chamada da verificação semântica
          // Chamada da geração de código
        }
        ;

stmts : stmts stmt {
          node *origin = $1;

          origin = realloc (origin, sizeof(node) + sizeof(node*) * origin->childCount);
          
          origin->children[origin->childCount] = $2;
          
          origin->childCount++;

          $$ = origin;
      }  
      | stmt {
          $$ = create_node (STMT, 1);
          $$ -> children[0] = $1;
      }
      ;
      
stmt : assignment {
          $$ = $1;
          // Instruções abaixo representa uma arvore abstrata
          // $$ = create_node (GENERIC, 1);
          // $$ -> children[0] = $1;
     }
     | TOKEN_PRINT arithmetic { 
          $$ = create_node (PRINT, 1);
          $$ -> children[0] = $2;
     }
     // | //Declaração função
     // | //Declaração laços
     | if {
          $$ = $1;
     }
     ;

assignment : TOKEN_IDENT '=' arithmetic { 
               $$ = create_node (ASSIGN, 2);
               $$ -> children[0] = create_node (IDENT, 0);
               $$ -> children[0] -> name = $1.ident;
               $$ -> children[1] = $3;
           }
           ;

if: TOKEN_IF '(' logicalExpression ')' '{' stmts '}' {
               $$ = create_node (CONDITIONAL, 2);
               $$ -> children[0] = $3;
               $$ -> children[1] = $6;
          }
          ;

logicalExpression: logicalExpression TOKEN_OR logicalExpressionTerm {
                    $$ = create_node (LOGICAL_OR, 2);
                    $$ -> children[0] = $1;
                    $$ -> children[1] = $3;
                 }
                 | logicalExpressionTerm {
                    $$ = $1;
                 }
                 ;

logicalExpressionTerm: logicalExpressionTerm TOKEN_AND logicalFactor {
                    $$ = create_node (LOGICAL_AND, 2);
                    $$ -> children[0] = $1;
                    $$ -> children[1] = $3;
                 }
                 | logicalFactor {
                    $$ = $1;
                 }
                 ;

logicalFactor: '(' logicalExpression ')' {
               $$ = $2;
             }
             | arithmetic '>' arithmetic {
               $$ = create_node (GREATER_THAN, 2);
               $$ -> children[0] = $1;
               $$ -> children[1] = $3;
             }
             | arithmetic '<' arithmetic {
               $$ = create_node (LESS_THAN, 2);
               $$ -> children[0] = $1;
               $$ -> children[1] = $3;
             }
             | arithmetic TOKEN_EQUAL arithmetic {
               $$ = create_node (EQUAL, 2);
               $$ -> children[0] = $1;
               $$ -> children[1] = $3;
             }
             | arithmetic TOKEN_NOT_EQUAL arithmetic {
               $$ = create_node (NOT_EQUAL, 2);
               $$ -> children[0] = $1;
               $$ -> children[1] = $3;
             }
             | arithmetic TOKEN_LESS_THAN_OR_EQUAL arithmetic {
               $$ = create_node (LESS_THAN_OR_EQUAL, 2);
               $$ -> children[0] = $1;
               $$ -> children[1] = $3;
             }
             | arithmetic TOKEN_GREATER_THAN_OR_EQUAL arithmetic {
               $$ = create_node (GREATER_THAN_OR_EQUAL, 2);
               $$ -> children[0] = $1;
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
               $$ = $1;
               // Instruções abaixo representa uma arvore abstrata
               // $$ = create_node (GENERIC, 1);
               // $$ -> children[0] = $1;
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
          $$ = $1;
          // Instruções abaixo representa uma arvore abstrata
          // $$ = create_node (GENERIC, 1);
          // $$ -> children[0] = $1;
     }
     ;

term2 : term2 '^' factor { 
          $$ = create_node (POW, 2);
          $$ -> children[0] = $1;
          $$ -> children[1] = $3;
     }
     | factor {
          $$ = $1;
          // Instruções abaixo representa uma arvore abstrata
          // $$ = create_node (GENERIC, 1);
          // $$ -> children[0] = $1;
     }
     ;

factor : '(' arithmetic ')' { 
          $$ = $2;
          // Instruções abaixo representa uma arvore abstrata
          // $$ = create_node (PARENT, 1);
          // $$ -> children[0] = $2;
       }
       | TOKEN_IDENT {
          $$ = create_node (IDENT, 0);
          $$ -> name = $1.ident;
       }
       | TOKEN_INTEGER  {
          $$ = create_node (INTEGER, 0);
          $$ -> intv = $1.intv;
       }
       | TOKEN_FLOAT {
          $$ = create_node (FLOAT, 0);
          $$ -> dblv = $1.dblv;
       }
       ;

%%

int yyerror (const char *s) {
     printf("Erro na linha %d: %s\n", yylineno, s);
	return 1;
}
