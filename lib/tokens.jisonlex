// Jison lexer grammar

//// Macros
DIGIT    									[0-9]
NUMBER   									{DIGIT}+(\.{DIGIT}+)? // matches 10 and 3.14
NAME     									[a-zA-Z][\w\-]* //matches body, background-color and myClass
SELECTOR 									(\.|\#|\:\:|\:){NAME} //matches #id, .class, :hover and ::before

%%

//// Rules

\s+							// ignore space, line breaks, tabs etc.

// Numbers
{NUMBER}(px|em|\%)				return 'DIMENSION' 	// 10px, 1em, 50%
{NUMBER}									return 'NUMBER' 		// 0
\#[0-9A-Fa-f]{3,6}				return 'COLOR' 			// #fff, #fafafa

//Selectors
{SELECTOR} 								return 'SELECTOR' 	// .class, #id or ::before
{NAME}{SELECTOR}					return 'SELECTOR' 	// div.class, div#id

{NAME}										return 'IDENTIFIER' // body, font-size

.													return yytext 			// {, }, +, :, ;

<<EOF>>										return 'EOF'