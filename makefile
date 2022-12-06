all:
	bison -d birl.y
	flex birl.l
	gcc birl.tab.c lex.yy.c header.c -o birl.out
	./birl.out test2-error.birl
