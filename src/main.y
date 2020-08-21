%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
void yyerror (char *c);
int yylex(void);
int i = 0;
int f = 0;
%}

%token NUM VEZES DIVISAO POTENCIA EPAREN DPAREN EOL INICIO
%token MENOS
%token ADICAO

%left ADICAO MENOS
%left VEZES DIVISAO
%left POTENCIA
%left EPAREN DPAREN

%%

INPUT: INPUT NUM {printf("potencia:\nMUL C\nDEC B\nJNZ potencia\nRET\n");}
	|{}
	|INPUT LINHA{printf("TESTE final\n");};


LINHA: EXPRESSAO EOL {printf(" ; O resultado final é pra ser: %d\n", $1);};



EXPRESSAO: 	 EPAREN EXPRESSAO DPAREN {$$ = $2; }

	| NUM {$$ = $1;printf("PUSH %d\n",$1);} 
	| EXPRESSAO POTENCIA EXPRESSAO {if ($3==0)
	{
	$$=1; printf("POP B\nPOP A\nMOV A, 1\nPUSH A\n");
	}
	else {printf("POP B\nPOP A\nMOV C,A\nDEC B\n");
	printf("potencia%d:\nMUL C\nDEC B\nJNZ potencia%d\nPUSH A\n", i,i);
		i++;}}

	| EXPRESSAO VEZES EXPRESSAO {$$ = $1 * $3; printf("POP B\nPOP A\nMUL B\nPUSH A\n"); }
	| EXPRESSAO DIVISAO EXPRESSAO {$$ = $1 / $3; printf("POP B\nPOP A\nDIV B\nPUSH A\n");}
	| EXPRESSAO ADICAO EXPRESSAO {$$ = $1 + $3;  printf("POP B\nPOP A\nADD A, B\nPUSH A\n");}
	| EXPRESSAO MENOS EXPRESSAO {$$ = $1 - $3;printf("POP B\nPOP A\nSUB A, B\nPUSH A\n");}
;

%%

/*Chamada da função*/
void yyerror (char *c) {
printf("Erro!!\n");
}

int main (){
	yyparse();
	return 0;
}
