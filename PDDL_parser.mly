/* Lexer for PDDL language  
	
		  @file parser.mly
		  @author Sagado
*/

%token DEF
%token DOM
%token REQ
%token TYP
%token STRP
%token TYPNG
%token CONST
%token PRED
%token ACT
%token PARAM
%token PREC
%token EFFECT
%token AND
%token NOT

%token <string> ID
%token <string> VAR

%token LP
%token RP
%token HYPEN

%start main
%type <string> main

%%

main:
	definition operators  { $1^$2 }
;


/* definition part */
	definition:
		LP define RP LP requirements RP LP TYP types RP LP CONST constants RP LP PRED predicates RP 	{$2^$5^"\ntypedef string "^$9^";\n"^$13^$17}
	;

	define:
		 DEF DOM ID	{"\n//define domain "^$3}
	;

	requirements:
		REQ STRP TYPNG	{"\n//requirements strips typing\n"}		
	;

	types:
		ID	{$1}
		| ID types	{$1^", "^$2}
	;

	constants:
		types;	{"\n//const "^$1}
	;
	
	predicates:
		LP ID vars RP	{"\nbool "^$2^" ("^$3^"){it = propositions.find(("^$2^$3^")); if (it != propositions.end())return true; else return false; };"}
		| LP ID vars RP predicates	{"\nbool "^$2^" ("^$3^")){it = propositions.find(("^$2^$3^"));if (it != propositions.end())return true;else return false; };"^$5}
	;


/* operators part */
	operators:
		LP ACT action RP			{ $3}
	;

	action:
		ID PARAM parameters PREC preconditions EFFECT effect	
				{"\nbool "^$1^" ("^$3^"){"^$5^$7^"};"}
	;

	parameters:
		LP vars RP	{ $2 }
	; 

	preconditions:	
		LP AND a_predicates RP	{"\nreturn "^$3}
	; 

	effect:
		LP AND a_predicates RP	{ "\nEFFECT return "^$3 }
	;
	
	a_predicates:
		LP ID a_vars RP		{$2^" ("^$3^");"}
		| LP NOT LP ID a_vars RP RP	{"! "^$4^" ("^$5^");"}
		| LP ID a_vars RP a_predicates	{$2^" ("^$3^");"^$5}
	;

	a_vars:
		VAR	{ String.sub $1 1 (String.length($1)-1) }	
		| VAR a_vars	{ (String.sub $1 1 (String.length($1)-1) )^" "^$2}
	;

vars:
	var		{ $1 }
	| var vars	{ $1^", "^$2 }
;

var:
	VAR HYPEN ID		{$3^" "^(String.sub $1 1 (String.length($1)-1) )}
	| VAR var 		{$2^", "^(String.sub $1 1 (String.length($1)-1) )}
;
