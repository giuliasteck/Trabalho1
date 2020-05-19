COMPILER = gcc
CFLAGS = -Wextra -ll
DIR = src
YACC = bison
LEX = flex
FILE = $(DIR)/main.c
HTAB = $(DIR)/y.tab.h
CTAB = $(DIR)/y.tab.c
YACCPROGRAM = $(DIR)/main.y
LEXPROGRAM = $(DIR)/main.l
LEXEXEC = $(DIR)/lex.yy.c
BFLAG = -dy
TARGET = ./calculadora
OBJS = ${SRCS:.c=.o} 

#Testes
BASH = sh
TESTES = test.sh


.PHONY: depend clear

all: $(TARGET)

$(TARGET):$(LEXEXEC) $(CTAB)
	$(COMPILER) -o$(TARGET) $(LEXEXEC) $(CTAB) $(CFLAGS)

$(LEXEXEC):$(LEXPROGRAM) $(CTAB)
	$(LEX) -o$(LEXEXEC) $(LEXPROGRAM)

$(CTAB): $(YACCPROGRAM)
	$(YACC) $(BFLAG) -o$(CTAB) $(YACCPROGRAM)

test:all
	$(BASH) $(TESTS) $(TARGET)

clean:
	$(RM) $(HTAB)
	$(RM) $(CTAB)
	$(RM) $(LEXPROGRAM)
	$(RM) $(YACCPROGRAM)
	$(RM) ./$(TARGET)
	$(RM) $(DIR)/*.o
