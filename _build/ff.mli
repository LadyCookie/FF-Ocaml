

open Graph

(*list of nodes*)
type path= id list

(*
(*create an ecart graph from a graph*)
val ecart_of_graph: int graph -> int graph
*)

val graph_of_ecart: int graph -> int graph -> id -> int graph

(*apply flow in an option path *)
val opt_apply_flow : int graph -> id list option -> int -> int graph

(*find a path from 2 nodes in an int graph*)
val find_path : int graph -> id -> id -> id list option

(*find flow in a path*)
val find_flow : int graph -> id list option -> int

(*run the FF algorithm in a graph*)
val ff : int graph -> id -> id -> int graph
