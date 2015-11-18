%{
#include <stdio.h>
%}

Word	[a-zA-Z]+
Directive   ".. "[a-zA-Z_]+"::"
LiteralBlock "\n::\n"

%%
start   printf("Start command received\n");
stop    printf("Stop command received\n");
{Directive}+		{
	printf("found a directive: %s \n", yytext);
	}
::	{
	printf("Found a literal block: %s \n", yytext);
	}

%%

// stuff from lex that yacc needs to know about:
extern int yylex();
extern int yyparse();
extern FILE *yyin;


int main(int argc, char *argv[]) {
	++argv, --argc;	/* skip over program name */
	if ( argc > 0 )
	       yyin = fopen( argv[0], "r" );
	else
	       yyin = stdin;

	yylex();
	return 0;
}
