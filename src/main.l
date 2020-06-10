/*Inicio do programa para identificação de simbolos*/

%{
#include <stdlib.h>
void yyerror (char *);

#include "y.tab.h"

%}
/*Incluir numeros*/
DIGITO [0-9]
NUMERO {DIGITO}+

%%

{NUMERO} {yylval = atoi(yytext);
		return NUM;
	   }



[+] return ADICAO;
[-] return MENOS;
[*] return VEZES;
[/] return DIVISAO;
"^" return POTENCIA;
[(] return EPAREN;
[)] return DPAREN;
[\n] return EOL;

. ;
%%
/*conversão de simbolos em valores que  irão para yylex*/
int yywrap () {
	return 1;
}
