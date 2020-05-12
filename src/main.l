%{
#include <stdlib.h>
void yyerror (char *);

#include "y.tab.h"

%}

DIGITO [0-9]
NUMERO {DIGITO}+

%%

{NUMERO} {yylval = atoi(yytext);
		return NUM;
	   }
[-]{1,1}{NUMERO} {yylval = atoi(yytext);
				 return NEG;
				 }

[+] return ADICAO;
[-] return MENOS;
[*] return VEZES;
[/] return DIVISAO;
"^" return POTENCIA;
[(] return EPAREN;
[)] return DPAREN;
[\n] return EOL;


%%

int yywrap () {
	return 1;
}
