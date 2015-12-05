%{
#include <stdio.h>
%}

space			[ \t\n\r\f]
whitespace		({space}+)
newline			[\n\r]
word			[a-zA-Z]+
xeunicode		[\\](u[0-9A-Fa-f]{4}|U[0-9A-Fa-f]{8})
simplename 		[^ \n\r]({word}|[-._+:]+)
rfc2822			[!-9;-~]+:( +|$)	
/**
 * Explicit constructs are began with ..
 */
explstart		".."
directive   		{explstart}{space}?{simplename}*{space}?"::"
hyperlink_target   	{explstart}{space}?"_"([^:])*{space}?
substitution_def   	{explstart}{space}?"|"{simplename}"|"
citation   	{explstart}{space}?"["{simplename}"]"{space}?


%%
start   printf("Start command received\n");
stop    printf("Stop command received\n");
{explstart}		{
	printf("Found a start of an explicit: %s \n", yytext);
	}
{hyperlink_target}		{
	printf("Found a hyperlink target: %s \n", yytext);
	}
{substitution_def}		{
	printf("Found a subsitition definition: %s \n", yytext);
	}
{directive}		{
	printf("Found a directive: %s \n", yytext);
	}


\n|.	;

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
