make:
	lex Lily.l
	yacc -v -d Lily.y
	gcc -o Lily lex.yy.c y.tab.c