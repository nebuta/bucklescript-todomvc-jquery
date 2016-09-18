type todo = {
	title : string;
	id : string;
	completed : bool;
};;

type state = {
	mutable todos : todo array;
	mutable filter : string;
};;
