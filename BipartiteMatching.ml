open Graph
open FF
open Printf
type path = string
let read_x graph line=
  try Scanf.sscanf line "x %s" (fun id-> add_arc (add_node graph (string_of_int ((int_of_string id)+2))) "0" (string_of_int((int_of_string id) + 2)) "1")
  with e -> failwith "convert"
let read_y graph line=
  try Scanf.sscanf line "y %s" (fun id-> add_arc (add_node graph (string_of_int ((int_of_string id)+2))) (string_of_int ((int_of_string id)+2)) "1" "1")
  with e -> failwith "convert"
let read_e graph line=
  try Scanf.sscanf line "e %s %s" (fun id1 id2 -> add_arc graph id1 id2 "1")
  with e -> failwith "convert"
(* convert : path -> string graph*)
let convert path=
  let infile = open_in path in
  let rec loop graph=
    try
      let line = input_line infile in
      let graph2=
        if line= "" then graph
        else match line.[0] with
          | 'x' -> read_x graph line
          | 'y' -> read_y graph line
          | 'e' -> read_e graph line
          | _ -> graph
      in
        loop graph2
    with End_of_file -> graph
  in
  (*la source a l'id 0, le puit l'id 1*)
  let final_graph = loop (add_node (add_node empty_graph "0") "1") in
    close_in infile;
    final_graph
(*
(* filter : int graph -> string graph*)
let filter graph=
*)
