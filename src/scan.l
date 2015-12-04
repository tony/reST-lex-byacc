%{
#include <stdio.h>
%}

space			[ \t\n\r\f]
whitespace		({space}+)
newline			[\n\r]
Word	[a-zA-Z]+
SimpleName ({Word}|[-._+:])
/**
 * Explicit constructs are began with ..
 */
explstart		".."
Directive   {explstart}{space}?{SimpleName}*{space}?
HyperlinkTarget   {explstart}{space}?"_"{SimpleName}
/*
 * LiteralBlock "{newline}::{newline}:
 */

%%
start   printf("Start command received\n");
stop    printf("Stop command received\n");
{explstart}		{
	printf("Found a start of an explicit: %s \n", yytext);
	}
{HyperlinkTarget}		{
	printf("Found a hyperlink target: %s \n", yytext);
	}
{Directive}		{
	printf("Found a directive: %s \n", yytext);
	}


:::	{
	printf("Found a literal block: %s \n", yytext);
	}
\n	;
.	;

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
