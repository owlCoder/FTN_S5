%option noyywrap yylineno
%{
  #include "text.tab.h"
%}

%%

[ \t\n]+    { /* skip */ }

"."         { return _DOT; }
":"         { return _COLON; }

HAMLET|KLAUDIJE|OFELIJA { return _ACTOR; }

[A-Z][a-z]* { return _CAPITAL_WORD; }
[a-z]+      { return _WORD; }
                 
.           { printf("\nline %d: LEXICAL ERROR on char %c", 
                      yylineno, *yytext); }    

