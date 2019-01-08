# FF-Ocaml

Pour la partie Ford-Fulkerson,
compiler:
~ocamlbuild ff_test.native
executer:
~./ff_test.native infile source sink outfile

Note: un fichier infile est déjà disponible sous le nom de graph1

Pour la partie couplage Biparti,
compiler:
~ocamlbuild biparti_test.native
executer:
~./biparti_test.native infile outfile

Note: un fichier infile est déjà disponible sous le nom de graphBiparti.txt



Note: pour convertir le fichier outfile.dot en png, utiliser la commande:
~dot -Tpng outfile > outfile.png
