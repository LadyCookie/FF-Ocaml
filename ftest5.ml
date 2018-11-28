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
  
  let flow =find_flow int_graph opt_chemin in
  
  let graph_bis=opt_apply_flow int_graph opt_chemin flow in

  let opt_chemin_bis = find_path graph_bis _source _sink in
  
  let flow_bis =find_flow graph_bis opt_chemin_bis in

  let graph_ter=opt_apply_flow graph_bis opt_chemin_bis flow_bis in

  let graph4= graph_of_ecart int_graph graph_ter _source in

  let final_graph=Graph.map graph4 string_of_int in
  
  let chemin= match opt_chemin_bis with
    |None -> failwith "pas de chemin"
    |Some x -> x
  in

  (* Rewrite the graph that has been read. *)
  let () =
  Printf.printf " %d \n%!"(flow_bis);
  List.iter (fun x -> Printf.printf " %s \n%!"(x)) chemin;
  Gfile.export outfile final_graph
  

  in
  ()
