(** Lexer for PDDL language  
	
		  @file lexer.mll
		  @author 5agado
*)

{
	open PDDL_parser;;
	exception Eof;;
	exception UnknownChar;;
}

(* definitions section *)
let white_space = [' '] | ['\t'] | ['\r'] | ['\n']
let comment = [';']|[';'';'][^'\n']*'\n'
let id = ['a'-'z']+
let var = '?'['a'-'z']+['0'-'9']?

(* rules section *)	
rule token = parse
	  white_space			{ token lexbuf }	(* skip the white spaces *)
	| comment			{ token lexbuf }	(* skip the comment *)
	| '('				{ LP }
	| ')'				{ RP }
	| '-'				{ HYPEN }
	| "define"			{ DEF }
	| "domain"			{ DOM }
	| ":requirements"		{ REQ }
	| ":types"			{ TYP }
	| ":strips"			{ STRP }
	| ":typing"			{ TYPNG }
	| ":constants"			{ CONST }
	| ":predicates"			{ PRED }
	| ":action"			{ ACT }
	| ":parameters"			{ PARAM }
	| ":precondition"		{ PREC }
	| ":effect"			{ EFFECT }
	| "and"				{ AND }
	| "not"				{ NOT }
	| var				{ VAR (Lexing.lexeme lexbuf) }
	| id				{ ID (Lexing.lexeme lexbuf) }
	| eof				{ raise Eof }
	| _             		{ raise UnknownChar }
	
