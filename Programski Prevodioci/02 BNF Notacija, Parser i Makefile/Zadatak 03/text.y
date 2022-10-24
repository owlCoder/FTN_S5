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

%%

text
  : paragraph _NEW_LINE      { paragraph_counter++; }
  | text paragraph _NEW_LINE { paragraph_counter++; }
  ;

paragraph
  : sentence
  | paragraph sentence
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
    Zadatak 3:
      Proširiti tekst gramatiku pasusima:
        - Tekst je niz od jednog ili više pasusa.
        - Pasus je niz od jedne ili više rečenica.
        - Pasusi su odvojeni bar jednim znakom NEWLINE.
      
        Na kraju programa ispisati ukupan broj pasusa.
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
