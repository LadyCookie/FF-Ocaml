cd /d "D:\"
cd Cours/4A/ProgFonc/Projet/FF-Ocaml

ocamlc -c graph.mli
ocamlc -c graph.ml
ocamlc -c gfile.mli
ocamlc -c gfile.ml
ocamlc -c FF.mli
ocamlc -c FF.ml
ocamlc -c bipartitematching.mli
ocamlc -c bipartitematching.ml

ocamlc -o ftest8.exe graph.cmo gfile.cmo FF.cmo bipartitematching.cmo ftest8.ml
pause
