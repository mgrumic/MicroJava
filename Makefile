LEX_FILES=ppdz/MJLexer.lex
OUT_FILES=ppdz/Yylex.java ppdz/*.class ppdz/Yylex.java~
TEST_FILE=ppdz/MJTest.java
CUP_FILE=ppdz/mjparser.cup

CPATH=.:..:ppdz/:java-cup-11a.jar:symboltable-1.1.0.jar
JAVA=java
JAVAC=javac

all: test

JFlex: ppdz/MJLexer.lex
	$(JAVA) -jar JFlex.jar ppdz/MJLexer.lex

sym: JFlex ppdz/sym.java
	$(JAVAC) ppdz/sym.java

Yylex: JFlex ppdz/Yylex.java
	$(JAVAC) -cp $(CPATH) ppdz/Yylex.java

test: JFlex sym Yylex
	$(JAVAC) -cp $(CPATH) $(TEST_FILE)

parser: ppdz/MJLexer.lex ppdz/sym.java ppdz/Yylex.java
	$(JAVA) -jar java-cup-11a.jar -destdir ppdz $(CUP_FILE)
	$(JAVAC) -cp $(CPATH) ppdz/parser.java

run_parser: ppdz/MJTest.java
	@echo "******************* ISPRAVAN PROGRAM ***************************"
	@$(JAVA) -cp $(CPATH) ppdz/MJTest test/program.mj
	@echo "******************* NEISPRAVAN PROGRAM ***************************"
	# $(JAVA) -cp $(CPATH) ppdz/MJTest test/programErr.mj


run_test: ppdz/MJTest.java
	@echo "******************* ISPRAVAN PROGRAM ***************************"
	$(JAVA) -cp $(CPATH) ppdz/parser test/program.mj
	
	@echo "******************* NEISPRAVAN PROGRAM ***************************"
	$(JAVA) -cp $(CPATH) ppdz/parser test/programErr.mj


clean:
	rm -rf $(OUT_FILES) 

help:
	@echo "make JFlex (Lex file -> Yylex.java, generate lexic analyzer)"
	@echo "make sym   (Generate symbol table class)"
	@echo "make test  (Compile test class)"
	@echo "make all   (JFlex sym test)"
	@echo "make clean (clean all files, leave only src files)"
