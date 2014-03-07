// Jison parser grammar


%{
	var nodes = require('./nodes')
%}

%%

// Parsing starts here
stylesheet:
	rules EOF											{ return new nodes.StyleSheet($1) }
;

rules:
	rule                      		{ $$ = [ $1 ]}
| rules rule 										{ $$ = $1.concat($2) }
;

rule:
	selector '{' properties '}'		{ $$ = new nodes.Rule($1, $3) }
;

selector:
	IDENTIFIER
|	SELECTOR
;

properties:
	/* empty */										{ $$ = [] }
|	property                   		{ $$ = [ $1 ]}
| properties ';' property 			{ $$ = $1.concat($3) }
| properties ';'								{ $$ = $1 }
;

property:
	IDENTIFIER ':' values					{ $$ = new nodes.Property($1, $3) }
;


values:
	value                      		{ $$ = [ $1 ]}
| values value 									{ $$ = $1.concat($2) }
;

value:
	IDENTIFIER
| COLOR
| DIMENSION
;
