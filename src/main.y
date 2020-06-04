%{

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
void yyerror (char *c);
int yylex(void);
int i = 0;
int f = 0;
%}

%token NUM
%token ADICAO MENOS VEZES DIVISAO POTENCIA
%token EPAREN DPAREN
%token EOL

%left ADICAO MENOS
%left VEZES DIVISAO
%right POTENCIA
%right EPAREN DPAREN

%%

INPUT:  ;
INPUT: INPUT LINHA;

LINHA: EOL;

LINHA: EXPRESSAO EOL {printf("Resultado: %d\n", $1);};

EXPRESSAO:  
	NUM {$$ = $1;} 
	| EXPRESSAO ADICAO EXPRESSAO {$$ = $1 + $3; printf ("MOV A, %d\nMOV B, %d\nADD A,B\n", $1,$3);}
	| EXPRESSAO MENOS EXPRESSAO {$$ = $1 - $3; printf("MOV A, %d\nMOV B, %d\nSUB A,B\n", $1, $3);}
	| EXPRESSAO VEZES EXPRESSAO {$$ = $1 * $3; printf("MOV A, %d\nMOV B, %d\nMUL B\n", $1, $3); }
	| EXPRESSAO DIVISAO EXPRESSAO {$$ = $1 / $3; printf("MOV A, %d\nMOV B, %d\nDIV B\n", $1, $3); }
	| EXPRESSAO POTENCIA EXPRESSAO {if ($3==0){$$=1; printf("MOV A,1\n");}
				else {
				int i = 1;
				while (i < $3){
				$$ = $$*$1;
				i++;  
				};
				printf("MOV C, 1\nMOV A, %d\nMOV B, %d\nMOV D, %d\nPOTENCIA%d:\n	MUL B\n	INC C\n	CMP C,D\n	JNZ POTENCIA%d\n", $1, $1,$3,f,f);f++; }}
	| EPAREN EXPRESSAO DPAREN {$$ = $2; }


%%

void yyerror (char *c) {
}

int main (){
	yyparse();
	return 0;
}
