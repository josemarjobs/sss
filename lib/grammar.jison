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
	selector '{' declarations '}'		{ $$ = new nodes.Rule($1, $3) }
;

selector:
	IDENTIFIER
|	SELECTOR
;

declarations:
	/* empty */										  		{ $$ = [] }
|	declarationGroup                	 	{ $$ = $1 }
| declarations ';' declarationGroup  	{ $$ = $1.concat($3) }
| declarations ';'										{ $$ = $1 }
;

declarationGroup:
	property 														{ $$ = [ $1 ]}
| rules
| rules property 											{ $$ = $1.concat($2) }
;

property:
	IDENTIFIER ':' values					{ $$ = new nodes.Property($1, $3) }
;


values:
	value                      			{ $$ = [ $1 ]}
| values value 										{ $$ = $1.concat($2) }
;

value:
	IDENTIFIER
| COLOR
| DIMENSION
;
