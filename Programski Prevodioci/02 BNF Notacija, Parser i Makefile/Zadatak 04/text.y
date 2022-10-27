%{
  #include <stdio.h>
  int yylex(void);
  int yyparse(void);
  int yyerror(char *);
  extern int yylineno;

  int dot_sentence_counter = 0;
  int qmark_sentence_counter = 0;
  int emark_sentence_counter = 0;
  int paragraph_counter = 0;
%}

%token  _DOT
%token  _CAPITAL_WORD
%token  _WORD
%token _QMARK
%token _EMARK
%token _COMMA
%token _NEW_LINE
%token _COLON
%token _CHARACTER

%%

text
  : character sentence
  | text character sentence
  ;

character
  : _CHARACTER _COLON
  | /* empty */
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
  | words comma _WORD
  | words comma _CAPITAL_WORD
  ;

comma
  : /* empty */
  | _COMMA
  ;

%%

int main() {
  /*
    Zadatak 4:
      Proširiti tekst gramatiku tako da podržava format drama - ispred svake rečenice se može naći ime
      lica koje izgovara tu rečenicu.
        - Format je sledeći OSOBA ":" rečenica
        - OSOBA može uzimati jednu od tri vrednosti : HAMLET, KLAUDIJE, OFELIJA.
  */
  yyparse();

  printf("\nBroj izjavnih recenica je: %d", dot_sentence_counter);
  printf("\nBroj upitnih recenica je: %d", qmark_sentence_counter );
  printf("\nBroj uzvicnih recenica je: %d", emark_sentence_counter);
  printf("\nBroj pasusa je: %d\n\n", paragraph_counter);
}

int yyerror(char *s) {
  fprintf(stderr, "line %d: SYNTAX ERROR %s\n", yylineno, s);
} 
