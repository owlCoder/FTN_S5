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
%}

%token  _DOT
%token  _CAPITAL_WORD
%token  _WORD
%token  _UZVICNIK
%token  _UPITNIK
%token  _ZAREZ
%token  _NEWLINE
%token  _LPAREN
%token  _RPAREN

%%

left_prefix
  : _LPAREN
  | /* empty */
  ;

right_postfix
  : _RPAREN
  | /* empty */
  ;

text 
  : sentence
  | text sentence
  ;
          
sentence 
  : words _DOT              { no_of_dots++; }
  | words _UPITNIK          { upitnika++; }
  | words _UZVICNIK         { uzvicnika++; }
  ;

words 
  : left_prefix _CAPITAL_WORD right_postfix
  | words left_prefix _WORD right_postfix
  | words left_prefix _CAPITAL_WORD right_postfix
  | words right_postfix left_prefix
  | left_prefix right_postfix
  ;

%%

int main() {
  yyparse();
  // zadatak 1
  printf("\nBroj izjavnih recenica je: %d", no_of_dots);
  printf("\nBroj upitnih recenica je: %d", upitnika);
  printf("\nBroj pasusa je: %d", pasusa);
  printf("\nBroj uzvicnih recenica je: %d\n\n", uzvicnika);

  // zadatak 2
}

int yyerror(char *s) {
  fprintf(stderr, "line %d: SYNTAX ERROR %s\n", yylineno, s);
} 

