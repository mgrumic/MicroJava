LEX_FILES=ppdz/MJLexer.lex
OUT_FILES=ppdz/Yylex.java ppdz/*.class ppdz/Yylex.java~ ppdz/sym.java ppdz/parser.java
TEST_FILE=ppdz/MJTest.java
CUP_FILE=ppdz/mjparser.cup

CPATH=.:..:ppdz/:java-cup-11a.jar:symboltable-1.1.0.jar:mj-runtime.jar
JAVA=java
JAVAC=javac

all: test

JFlex: ppdz/MJLexer.lex
	$(JAVA) -jar JFlex.jar ppdz/MJLexer.lex

sym: JFlex parser
	$(JAVAC) -g ppdz/sym.java

Yylex: parser JFlex ppdz/Yylex.java
	$(JAVAC) -cp $(CPATH) -g ppdz/Yylex.java

test: JFlex sym Yylex
	$(JAVAC) -cp $(CPATH) -g $(TEST_FILE)

parser:
	$(JAVA) -jar java-cup-11a.jar -destdir ppdz $(CUP_FILE)
	$(JAVAC) -cp $(CPATH) -g ppdz/parser.java

run_parser: ppdz/MJTest.java
	@$(JAVA) -cp $(CPATH) ppdz/MJTest test/program.mj


run_test: program.obj
	$(JAVA) -cp mj-runtime.jar rs.etf.pp1.mj.runtime.Run program.obj ${ARGS}

disasm: program.obj
	$(JAVA) -cp mj-runtime.jar rs.etf.pp1.mj.runtime.disasm program.obj


clean:
	rm -rf $(OUT_FILES) 

help:
	@echo "make JFlex (Lex file -> Yylex.java, generate lexic analyzer)"
	@echo "make sym   (Generate symbol table class)"
	@echo "make test  (Compile test class)"
	@echo "make all   (JFlex sym test)"
	@echo "make clean (clean all files, leave only src files)"
