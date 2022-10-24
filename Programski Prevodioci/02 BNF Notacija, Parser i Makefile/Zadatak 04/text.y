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
%token _COMMA

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
    Zadatak 2:
      Proširiti tekst gramatiku tako da se bilo koje dve reči u rečenici mogu odvojiti jednim zarezom.
      Zarez ne sme da se pojavi iza poslednje reči.
  */
  yyparse();

  printf("\nBroj izjavnih recenica je: %d", dot_sentence_counter);
  printf("\nBroj upitnih recenica je: %d", qmark_sentence_counter );
  printf("\nBroj uzvicnih recenica je: %d\n\n", emark_sentence_counter);
}

int yyerror(char *s) {
  fprintf(stderr, "line %d: SYNTAX ERROR %s\n", yylineno, s);
} 
