all:
	bison -d calculadora.y
	flex calculadora.l
	gcc calculadora.tab.c lex.yy.c -o code.out
	./code.out test.3m

