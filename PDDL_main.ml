(** Lexer for PDDL language  
	
		  @file main.ml
		  @author Alex Martinelli
*)

let _ =
	try
		let channel = open_in "input.txt" in
			let lexbuf = Lexing.from_channel channel in
			while true do
				let result = PDDL_parser.main PDDL_lexer.token lexbuf in
					print_string result; print_newline(); flush stdout
			done
	with PDDL_lexer.Eof -> exit 0
