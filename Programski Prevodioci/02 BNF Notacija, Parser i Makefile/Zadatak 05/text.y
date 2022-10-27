%{
  #include <stdio.h>
  int yylex(void);
  int yyparse(void);
  int yyerror(char *);
  extern int yylineno;
  int no_of_dots = 0;
  int uzvicnika = 0;
  int upitnika = 0;
  int pasusa = 0;
  int clanova_liste = 0;
%}

%token  _DOT
%token  _CAPITAL_WORD
%token  _WORD
%token  _UZVICNIK
%token  _UPITNIK
%token  _ZAREZ
%token  _NEWLINE
%token  _NUMBER

%%

start
  : text_prefix text
  | /* empty */
  ;

text_prefix
  : list
  | /* empty */
  ;

list
  : _NUMBER _DOT sentence { clanova_liste++; }
  | list _NUMBER _DOT sentence { clanova_liste++; }
  ;

text 
  : sentence
  | text sentence
  ;
          
sentence 
  : words _DOT new_line              { no_of_dots++; pasusa++; }
  | words _UPITNIK  new_line         { upitnika++; pasusa++; }
  | words _UZVICNIK new_line         { uzvicnika++; pasusa++; }
  ;

words 
  : _CAPITAL_WORD
  | words comma _WORD
  | words comma _CAPITAL_WORD
  ;

comma
  :
  | _ZAREZ
  ; 

new_line
  :
  | _NEWLINE
  | new_line _NEWLINE
  ; 

%%

int main() {
  yyparse();
  // zadatak 1
  printf("\nBroj izjavnih recenica je: %d", no_of_dots);
  printf("\nBroj upitnih recenica je: %d", upitnika);
  printf("\nBroj pasusa je: %d", pasusa);
  printf("\nBroj clanova liste je: %d", clanova_liste);
  printf("\nBroj uzvicnih recenica je: %d\n\n", uzvicnika);

  // zadatak 2
}

int yyerror(char *s) {
  fprintf(stderr, "line %d: SYNTAX ERROR %s\n", yylineno, s);
} 

