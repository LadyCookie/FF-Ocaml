open Graph
open Ff

let () =

  if Array.length Sys.argv <> 5 then
    begin
      Printf.printf "\nUsage: %s infile source sink outfile\n\n%!" Sys.argv.(0) ;
      exit 0
    end ;

  let infile = Sys.argv.(1)
  and outfile = Sys.argv.(4)

  (* These command-line arguments are not used for the moment. *)
  and _source = Sys.argv.(2)
  and _sink = Sys.argv.(3)
  in

  (* Open file *)
  let graph = Gfile.from_file infile in

  let int_graph = Graph.map graph int_of_string in
  
  let opt_chemin = find_path int_graph _source _sink in
  
  let flow =find_flow int_graph opt_chemin
  in
  
  (* Rewrite the graph that has been read. *)
  let () = Printf.printf " %d \n%!"(flow)

  in
  ()


