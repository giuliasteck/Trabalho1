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
/*CHAMADA PARA PODER ESCREVER VARIAS EXPRESSÕES NA CALCULADORA, SEM QUE O PROFRAMA FECHE*/
INPUT: ;
INPUT: INPUT LINHA;
/*Escreve o valor final e termina o programa, com o resultado final no registrador 1*/

LINHA: EXPRESSAO EOL {printf(" ; O resultado final é pra ser: %d\n", $1);};

/*A "expressão é usada em forma de recursão, de forma que todas as operações estão contidas nessa expressão*/

EXPRESSAO:  
	/* A expressão pode ser un número, dessa forma o resultado que sobe na pilha será justamente esse número*/
	NUM {$$ = $1;} 
	/*Caso $2 seja "+" o programa lerá uma soma, subindo na pilha o resultado da soma dos dois valores. No Assembly, os valores em questão são repassados para os registradores e é executada a soma
OBS: as operações soma, subtração, multiplicação e divisão são de fácil aplicação, pois as operações ja estão implementadas no assembly em questão, dessa forma é necessário apenas chamá-las*/

	| EXPRESSAO ADICAO EXPRESSAO {$$ = $1 + $3; printf("MOV A, %d\nMOV B, %d\nADD A,B\n", $1,$3);}
	| EXPRESSAO MENOS EXPRESSAO {$$ = $1 - $3; printf("MOV A, %d\nMOV B, %d\nSUB A,B\n", $1, $3);}
	| EXPRESSAO VEZES EXPRESSAO {$$ = $1 * $3; printf("MOV A, %d\nMOV B, %d\nMUL B\n", $1, $3); }
	| EXPRESSAO DIVISAO EXPRESSAO {$$ = $1 / $3; printf("MOV A, %d\nMOV B, %d\nDIV B\n", $1, $3); }
	/*A exponenciação é implementada a partir de um elemento if, de forma que a estrutura de decisão irá comparar o valor da potencia com uma variável criada. A variavel é incrementada a cada retorno. No assembly será criada uma subrotina para cada potência, denominada "POTENCIA n", com n sendo o úmero relativo a quantidade de subrotinas já criadas.
OBS: para um valor cujo expoente é zero, foi criado um laço para que o valor que sobe na pilha seja 1.*/ 

	| EXPRESSAO POTENCIA EXPRESSAO {if ($3==0)
	{
	$$=1; 
	printf("MOV A,1\n");
	}
	else if ($3 ==1){
	$$ = $1;
		printf("MOV A,%d\n", $1);}
	else {
		int i = 1;
		while (i < $3){
			$$ = $$*$1;
			i++;  
			};
		printf("MOV C, 1\nMOV A, %d\nMOV B, %d\nMOV D, %d\nPOTENCIA_%d:\n	MUL B\n	INC C\n	CMP C,D\n	JNZ POTENCIA_%d\n", $1, $1,$3,f,f);f++; }}

	/*por fim, os parenteses estão dispostos de forma que apenas o valor do seu interior suba na pilha. No assemply, não há necessidade de qualquer codigo. O parenteses tem prioridade, sendo necessário resolver primeiro o que está no interior do parenteses, para depois resolver as outras operações.*/	
	| EPAREN EXPRESSAO DPAREN {$$ = $2; }

%%

/*Chamada da função*/
void yyerror (char *c) {
}

int main (){
	yyparse();
	return 0;
}
