type todo = {
	title : string;
	id : string;
	completed : bool;
};;

type filterType = All | Active | Completed;;

let readFilter s =
	match s with
		"all" -> All;
		| "active" -> Active;
		| "completed" -> Completed;
		| _ -> All;;

type state = {
	mutable todos : todo array;
	mutable filter : filterType;
};;

type derivedState = {
 todoIdx : (string,int) Hashtbl.t;
};;