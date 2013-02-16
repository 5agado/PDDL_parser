PHONY : all clean

all: PDDL_lexer.cmo PDDL_parser.cmo PDDL_main.cmo
	ocamlc -o PDDL $^

PDDL_lexer.ml : PDDL_lexer.mll PDDL_parser.cmi
	ocamllex PDDL_lexer.mll

PDDL_parser.ml : PDDL_parser.mly
	ocamlyacc PDDL_parser.mly

PDDL_parser.cmi : PDDL_parser.ml
	ocamlc -c PDDL_parser.mli

PDDL_parser.cmo : PDDL_parser.ml PDDL_parser.mli
	ocamlc -c PDDL_parser.ml

%.cmo : %.ml
	ocamlc -c $<

clean:
	rm -rf PDDL_parser.mli PDDL_parser.ml PDDL_lexer.ml *.cmo *.cmi PDDL

