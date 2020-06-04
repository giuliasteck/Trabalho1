<<<<<<< HEAD
# Macros para compilacao
CC = gcc
CFLAGS = -Wextra -lfl
DIR = src
FILENAME = $(DIR)/main.c
YYTABH = $(DIR)/y.tab.h
YYTABC = $(DIR)/y.tab.c
LEXOUT = $(DIR)/lex.yy.c
YACCFILE = $(DIR)/main.y
LEXFILE = $(DIR)/main.l
TARGET = ./main
BJS = $(SRCS:.c=.o)
YACC = bison
LEX = flex


# Macros para teste
BASH = sh
TEST_SCRIPT = test.sh
VERBOSE ?= 1

# Macros para construcao do zip
ZIP = zip
USERNAME ?= $(USER)
ZIPFILE = $(USERNAME).zip
EXTENSIONS = *.c *.h *.in *.out *.sh

.PHONY: depend clean

all:$(TARGET)

$(TARGET):$(LEXOUT) $(YYTABC)
	$(CC) -o$(TARGET) $(LEXOUT) $(YYTABC) $(CFLAGS)

$(LEXOUT):$(LEXFILE) $(YYTABC)
	$(LEX) -o$(LEXOUT) $(LEXFILE)

$(YYTABC):$(YACCFILE)
	$(YACC) -o$(YYTABC) -dy $(YACCFILE)

test:all
	$(BASH) $(TEST_SCRIPT) $(TARGET) $(VERBOSE)

zip:clean
	$(ZIP) -R $(ZIPFILE)  Makefile $(EXTENSIONS)

clean:
	$(RM) $(YYTABC)
	$(RM) $(YYTABH)
	$(RM) $(LEXOUT)
	$(RM) ./$(TARGET)
	$(RM) $(DIR)/*.o
	$(RM) ./$(ZIPFILE)
=======
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
>>>>>>> b79ac9fb1a251fe7ea8e3257faf48966ae3e9649
