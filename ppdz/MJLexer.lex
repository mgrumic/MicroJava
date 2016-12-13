//IMPORT SEKCIJA

package ppdz;

import java_cup.runtime.Symbol;

%%
//JFLEX DIREKTIVE

%{
	StringBuffer string = new StringBuffer();


	private Symbol new_symbol(int type) {
		return new Symbol(type, yyline+1, yycolumn);
	}

	private Symbol new_symbol(int type, Object value) {
		return new Symbol(type, yyline+1, yycolumn, value);
	}

%}


%cup
%line
%column

%xstate COMMENT
%xstate STRING

%eofval{
	return new_symbol(sym.EOF);
%eofval}


%%
//REGULARNI IZRAZI

" "		{ }
"\b"		{ }
"\t"		{ }
"\r\n"		{ }
"\n"		{ }
"\f"		{ }


"program"	{ return new_symbol(sym.PROG, yytext()); }


"//"			{ yybegin(COMMENT); }
<COMMENT> .		{ yybegin(COMMENT); }
<COMMENT> "\r\n" 	{ yybegin(YYINITIAL); }
<COMMENT> "\n"		{ yybegin(YYINITIAL); }


"const"			{ return new_symbol(sym.CONST, yytext()); }
"void"			{ return new_symbol(sym.VOID, yytext()); }
"if"			{ return new_symbol(sym.IF, yytext()); }
"else"			{ return new_symbol(sym.ELSE, yytext()); }
"while"			{ return new_symbol(sym.WHILE, yytext()); }
"read"			{ return new_symbol(sym.READ, yytext()); }
"break"			{ return new_symbol(sym.BREAK, yytext()); }
"return"		{ return new_symbol(sym.RETURN, yytext()); }
"print"			{ return new_symbol(sym.PRINT, yytext()); }
"do"			{ return new_symbol(sym.DO, yytext()); }
"class"			{ return new_symbol(sym.CLASS, yytext()); }
"new"			{ return new_symbol(sym.NEW, yytext()); }
"extends"		{ return new_symbol(sym.EXTENDS, yytext()); }


"."			{ return new_symbol(sym.DOT, yytext()); }
"{"			{ return new_symbol(sym.LBRACE, yytext()); }
"}"			{ return new_symbol(sym.RBRACE, yytext()); }
"("			{ return new_symbol(sym.LPAREN, yytext()); }
")"			{ return new_symbol(sym.RPAREN, yytext()); }
","			{ return new_symbol(sym.COMMA, yytext()); }
"["			{ return new_symbol(sym.LBRACKET, yytext()); }
"]"			{ return new_symbol(sym.RBRACKET, yytext()); }
";"			{ return new_symbol(sym.SEMI, yytext()); }

"||"			{ return new_symbol(sym.OR, yytext()); }
"&&"			{ return new_symbol(sym.AND, yytext()); }

"++"			{ return new_symbol(sym.INCREMENT, yytext()); }
"--"			{ return new_symbol(sym.DECREMENT, yytext()); }
"=="			{ return new_symbol(sym.EQUALS, yytext()); }
"="			{ return new_symbol(sym.ASSIGN, yytext()); }
"!="			{ return new_symbol(sym.NEQUALS, yytext()); }
">"			{ return new_symbol(sym.MORE, yytext()); }
">="			{ return new_symbol(sym.MOREQUAL, yytext()); }
"<"			{ return new_symbol(sym.LESS, yytext()); }
"<="			{ return new_symbol(sym.LESSEQUAL, yytext());}
"+"			{ return new_symbol(sym.PLUS, yytext()); }
"-"			{ return new_symbol(sym.MINUS, yytext()); }
"*"			{ return new_symbol(sym.TIMES, yytext()); }
"/"			{ return new_symbol(sym.DIV, yytext()); }
"%"			{ return new_symbol(sym.PERCENT, yytext()); }


"true"			{ return new_symbol(sym.BOOLCONST, yytext()); }
"false"			{ return new_symbol(sym.BOOLCONST, yytext()); }

[\'][\b-~][\']		{ return new_symbol(sym.CHAR, new Character(yytext().charAt(1))); }
[0-9]+			{ return new_symbol(sym.NUMBER, new Integer(yytext())); }
([a-z]|[A-Z])[a-z|A-Z|0-9|_]*	{ return new_symbol(sym.IDENT, yytext()); }

\"			{ string.setLength(0); yybegin(STRING); }
<STRING> "\r\n"		{ System.err.println("Lexical Error: Quotes are not closed, line: " + (yyline + 1) + "."); }
<STRING> "\n"		{ System.err.println("Lexical Error: Quotes are not closed, line: " + (yyline + 1) + "."); }
<STRING> \\t		{ string.append('\t'); }
<STRING> \\r		{ string.append('\r'); }
<STRING> \\n		{ string.append('\n'); }
<STRING> \\\"		{ string.append('\"'); }
<STRING> \\		{ string.append('\\'); }
<STRING> \"		{ yybegin(YYINITIAL); return new_symbol(sym.STRCONST, string.toString()); }

.			{ System.err.println("Leksicka greska (" + yytext() + ") u liniji " + (yyline+1)); }


