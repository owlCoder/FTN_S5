%{
  #include <stdio.h>
  int yylex(void);
  int yyparse(void);
  int yyerror(char *);
  extern int yylineno;

  int dot_sentence_counter = 0;
  int qmark_sentence_counter = 0;
  int emark_sentence_counter = 0;
%}

%token  _DOT
%token  _CAPITAL_WORD
%token  _WORD
%token _QMARK
%token _EMARK

%%

text
  : sentence
  | text sentence
  ;

sentence
  : words end
  ;

end
  : _DOT   { dot_sentence_counter++; }
  | _QMARK { qmark_sentence_counter++; }
  | _EMARK { emark_sentence_counter++; }
  ;

words
  : _CAPITAL_WORD
  | words _WORD
  | words _CAPITAL_WORD
  ;

%%

int main() {
  /*
    Zadatak 1:
      Proširiti tekst gramatiku upitnim i uzvičnim rečenicama. Na kraju programa ispisati koliko ima
      upitnih, koliko uzvičnih, a koliko izjavnih rečenica.
  */
  yyparse();

  printf("\nBroj izjavnih recenica je: %d", dot_sentence_counter);
  printf("\nBroj upitnih recenica je: %d", qmark_sentence_counter );
  printf("\nBroj uzvicnih recenica je: %d\n\n", emark_sentence_counter);
}

int yyerror(char *s) {
  fprintf(stderr, "line %d: SYNTAX ERROR %s\n", yylineno, s);
} 

