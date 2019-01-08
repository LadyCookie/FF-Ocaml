open Graph
open FF

type path = string

(*convert a file of BM in string graph*)
val convert : path -> string graph

(*convert the graph after FF algorithm to an understable solution*)
val filter : int graph -> string graph

