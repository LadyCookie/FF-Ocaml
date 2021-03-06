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

  let opt_chemin = find_path graph _source _sink in

  let chemin= match opt_chemin with
    |None -> failwith "pas de chemin"
    |Some x -> x
  in
  
  (* Rewrite the graph that has been read. *)
  let () = List.iter (fun x -> Printf.printf " %s \n%!"(x)) chemin

  in
  ()


