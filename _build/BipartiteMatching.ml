open Graph
open Ff
open Printf
type path = string
let shift label=string_of_int((int_of_string label)+2)
let unshift label=string_of_int((int_of_string label)-2)
let read_x graph line=
  try Scanf.sscanf line "x %s" (fun id-> add_arc (add_node graph (shift id)) "0" (shift id) "1")
  with e -> failwith "convert"
let read_y graph line=
  try Scanf.sscanf line "y %s" (fun id-> add_arc (add_node graph (shift id)) (shift id) "1" "1")
  with e -> failwith "convert"
let read_e graph line=
  try Scanf.sscanf line "e %s %s" (fun id1 id2 -> add_arc graph (shift id1) (shift id2) "1")
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

(* filter : int graph -> string graph*)
let filter graph=
  let rec ajoutnode nodes gr_acu_nodes=
    match nodes with
      | "0" :: rest -> ajoutnode rest gr_acu_nodes
      | "1" :: rest -> ajoutnode rest gr_acu_nodes
      | id :: rest -> ajoutnode rest (add_node gr_acu_nodes (unshift id))
      | _ -> gr_acu_nodes
  in
  let ajout_arc acu idf=
    try
      let (id,flot)=List.find (fun (id, flot) -> (not(id="1") && flot==1)) (out_arcs graph idf) 
      in add_arc acu (unshift idf) (unshift id) "1"
    with Not_found -> acu
  in
  let rec loopnode nodes gr_acu=
    match nodes with
      | "0" :: rest -> loopnode rest gr_acu
      | "1" :: rest -> loopnode rest gr_acu
      | id :: rest -> loopnode rest (ajout_arc gr_acu id)
      | _ -> gr_acu
  in
    loopnode (out_nodes graph) (ajoutnode (out_nodes graph) empty_graph)

