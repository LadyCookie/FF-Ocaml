open Graph
open FF
open Bipartitematching

let () =
  if Array.length Sys.argv <> 3 then
    begin
      Printf.printf "\nUsage: %s infile outfile\n\n%!" Sys.argv.(0) ;
      exit 0
    end ;
  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(2)
  (* These command-line arguments are not used for the moment. *)
  in
  (* Open file *)
  let graph = Bipartitematching.convert infile in
  let int_graph = Graph.map graph int_of_string in
  let ff_graph = FF.ff int_graph "0" "1" in
  let final_graph=Graph.map ff_graph string_of_int in
  (* Rewrite the graph that has been read. *)
  let () =
    Gfile.export outfile final_graph
  in
    ()
