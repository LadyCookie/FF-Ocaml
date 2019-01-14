
open Graph

    
(*list of nodes*)
type path= id list


let find_path graph source sink=
  (*parcours en profondeur*)
	let rec loop forbidden lsource acu=
    (*si il y a un chemin direct, c'est fini, sinon, on cherche un fils permis, si il existe, on continue le parcours, si il n'existe pas, on remonte d'un cran*)
    	let path_impossible=
      		try 
				let (fils_permis,_) = List.find (fun (id,x) -> not (List.exists (fun numero -> numero == id) forbidden) && x>0 ) (out_arcs graph lsource)
				in loop (fils_permis::forbidden) fils_permis (fils_permis::acu)
      		with (*dans le cas ou aucun fils n'est permis*)
        		|Not_found -> match acu with
        		| [] -> assert false
				| [source] -> []
       			| first :: second :: rest -> loop forbidden second (second :: rest)
    	in
    
   		match (find_arc graph lsource sink) with
    		| Some x -> if (x<=0) then path_impossible else (sink::acu)
    		| None -> path_impossible 

  	in
  	let result=loop [source] source [source]
  	in
  	if (node_exists graph source) && (node_exists graph sink) 
  	then match result with
    	| [] -> None
   		| _ -> Some (List.rev result)
  	else None


let find_flow graph opt_path=
  let rec find_flow_rec path acu =
    match path with
    | [] -> acu
    | [x] -> acu
    | source :: (dest :: rest)  -> match find_arc graph source dest with
      |None -> failwith "Chemin erroné"
      |Some label -> if label < acu then find_flow_rec (dest :: rest) label else find_flow_rec (dest :: rest) acu
      
  in
  match opt_path with
  |None -> failwith "empty path"
  |Some [] -> failwith "Chemin erroné"
  |Some [x] -> failwith "Chemin erroné"
  |Some (x :: y :: rest) ->match find_arc graph x y with
    |None -> failwith "Chemin erroné"
    |Some label -> find_flow_rec (x::y::rest) label


let flow_arc graph source dest flow=
  match ((find_arc graph source dest),(find_arc graph dest source)) with
  | (None,_) -> failwith "case not possible"
  | (Some label,None) -> add_arc (add_arc graph source dest (label-flow)) dest source flow 
  | (Some label, Some labelRetour) -> add_arc (add_arc graph source dest (label-flow)) dest source (labelRetour+flow) 

let opt_apply_flow graph opt_path flow=
  let rec applyflow finalGraph path=
    match path with
    |[] -> finalGraph
    | [id] -> finalGraph
    | source  :: (dest :: rest) -> applyflow (flow_arc finalGraph source dest flow) (dest::rest)
  in
  match opt_path with
  |None -> failwith "problème algo"
  |Some path -> applyflow graph path



let graph_of_ecart graph gr_ecart source=
  let is_in_list l id=
    List.exists (fun x -> x==id) l in
  let rec loop_arc source_arc graph_arc list_arc list_nodes forbidden=
    match (list_arc,list_nodes) with
    |([],[]) -> graph_arc
    |([] , first :: rest) -> loop_arc first graph_arc (out_arcs graph first) rest (first :: forbidden)
    |( (dest,label) :: rest, _ ) -> let ajout_node= if (is_in_list forbidden dest || (is_in_list list_nodes dest)) then list_nodes else dest::list_nodes in
      match find_arc gr_ecart source_arc dest with
      | None ->  loop_arc source_arc graph_arc rest ajout_node forbidden
      | Some capa -> loop_arc source_arc (add_arc graph_arc source_arc dest (if label-capa<0 then 0 else label-capa)) rest ajout_node forbidden
  in
  loop_arc source graph (out_arcs graph source) [] [source]
    

let ff graph source sink=
	let rec loop graph_ecart=
  		match find_path graph_ecart source sink with
  			|None -> graph_ecart
  			|Some path -> loop (opt_apply_flow graph_ecart (Some path) (find_flow graph_ecart (Some path)))
	in
	graph_of_ecart graph (loop graph) source


