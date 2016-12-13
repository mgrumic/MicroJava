package ppdz;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;

import java_cup.runtime.Symbol;
import rs.etf.pp1.symboltable.*;

public class MJTest {

	public static void main(String[] args) throws IOException {
		Reader br = null;
		try {
			File sourceCode = new File(args[0]);	
			System.out.println("Compiling source file: " + sourceCode.getAbsolutePath());
			
			br = new BufferedReader(new FileReader(sourceCode));
			Tab.init();	
			Yylex lexer = new Yylex(br);
			parser p = new parser(lexer);
			Symbol currToken = p.parse();

			System.out.println("Broj globalnih promjenjivih: " + p.globalVariablesCount);
			System.out.println("Broj globalnih konstanti: " + p.globalConstantsCount);
			System.out.println("Statements in main: " + p.statementsInMainCount);
			System.out.println("Broj blokova naredbi: " + p.statementBlocksCount);
			System.out.println("Function calls in main: " + p.fcallInMainCount);
			System.out.println("Broj globalnih nizova: " + p.globalArrayDeclCount);
			System.out.println("Broj funkcija glavnog programa: " + p.functionDefinitionCount);
			System.out.println("Broj unutrasnjih klasa: " + p.innerClassCount);
			System.out.println("Broj metoda unutrasnjih klasa: " + p.innerClassMethodCount);
			System.out.println("Broj naredbi instanciranja klasa: " + p.instatiationStatementCount);


		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			if (br != null) try { br.close(); } catch (IOException e1) { e1.printStackTrace(); }
		}
	}
	
}
