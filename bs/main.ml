open Types
open Template
open Jquery
open ArrayOps
open Model

external urlHash : string = "window.location.hash" [@@bs.val]

let enter_key = 13;;
let escape_key = 27;;

let jq = jquery;;
let jq' = jquery';;

(* Global state for app *)
let state = {todos = [||]; filter = All};;
let derivedState = {todoIdx = Hashtbl.create 100};;

let toggle (jq : jquery) (flag : bool) : unit =
 	ignore (if flag then
 		show jq
 	else
 		hide jq);;

let indexFromEl el =
	let id = jquery' el |> closest "li" |> data_get "id" in
	Hashtbl.find derivedState.todoIdx id;;

let renderFooter () =
 	let activeTodoCount = Array.length (getFilteredTodos Active state.todos) in
 	let completedTodoCount = Array.length state.todos - activeTodoCount in
 	let activeTodoWord = pluralize activeTodoCount "item" in
	let html = footerTemplate
		activeTodoCount
		activeTodoWord
		completedTodoCount
		state.filter in
	ignore (jquery "#footer" |> Jquery.html html);
 	toggle (jquery "#footer") (Array.length state.todos > 0);;

let render () =
	calcIdx state.todos derivedState.todoIdx;
	let todos =
		try
			(* Ad hoc fix to avoid null value *)
			Js.log (Array.length state.todos);
			getFilteredTodos state.filter state.todos
		with
			_ ->
				state.todos <- [||];
				state.todos in
	let todoCount = Array.length todos in
	let html = todoTemplate todos in
	ignore (jquery "#todo-list" |> Jquery.html html);
 	toggle (jquery "#main") (todoCount > 0);

 	renderFooter ();
 	store_set "todos-jquery-bucklescript" todos;
	();;

let bind_events () =
	let newTodoKeyup = fun [@bs.this] jq e ->
		let input = jquery' e##target in
		let v = String.trim (input |> value_get) in
		if (e##which = enter_key && v <> "") then begin
			Js.log e;
			let t = {id = uuid (); title=v; completed=false} in
			array_append t state.todos;
			ignore (input |> value "");
			render ();
			true
		end else
			false
	in
	ignore (jq "#new-todo" |> on "keyup" newTodoKeyup);

	let destroy_body jq e =
		let i = indexFromEl e##target in
		state.todos <- array_splice i state.todos;
		render () in
	let destroy = fun [@bs.this] jq e ->
		destroy_body jq e;
		true in
	let edit = fun [@bs.this] jq e ->
		let input = jq' e##target |> closest "li"
			|> addClass "editing"  |> find ".edit" in
		let i = indexFromEl e##target in
		input |> value (state.todos.(i).title) |> focus;
		true in
	let editKeyup = fun [@bs.this] jq e ->
		if e##which == enter_key then
			ignore ((jq' e##target) |> blur)
		else if e##which == escape_key then
			ignore ((jq' e##target) |> data "abort" "true" |> blur);
		true in
	let onToggle = fun [@bs.this] jq e ->
		let i = indexFromEl e##target in
		state.todos.(i) <-
			{state.todos.(i)
				with completed = not state.todos.(i).completed};
		render ();
		true in
	let update = fun [@bs.this] jq e ->
		let el = jq' e##target in
		let i = indexFromEl e##target in
		let v = String.trim (el |> value_get) in
		if v = "" then
			destroy_body jq e
		else
			if el |> data_get "abort" = "true" then
				ignore (el |> data "abort" "false")
			else
				state.todos.(i) <-
					{state.todos.(i)
						with title = v};
		render ();
		true in
	let destroyCompleted = fun [@bs.this] jq e ->
		state.todos <- getFilteredTodos Active state.todos;
		state.filter <- All;
		render ();
		true in
	ignore (jq "#todo-list"
		|> on' "change" ".toggle" onToggle
		|> on' "dblclick" "label" edit
		|> on' "keyup" ".edit" editKeyup
		|> on' "focusout" ".edit" update
		|> on' "click" ".destroy" destroy);
	ignore (jq "#footer" |> on' "click" "#clear-completed" destroyCompleted);
	ignore (jq [%bs.raw "window"] |> on "hashchange" (fun [@bs.this] jq e ->
		state.filter <- readFilter (String.sub urlHash 2 (String.length urlHash - 2));
		render ();
		true
	));
	();;

let init () =
	Random.self_init ();
	(* state.filter <- readFilter (String.sub urlHash 2 (String.length urlHash - 2)); *)
	bind_events ();
	try
	 	ignore (state.todos <- store_get "todos-jquery-bucklescript");
	 	if Array.length state.todos = 0 then
	 		Js.log "0 item"
	with
		_ -> store_set "todos-jquery-bucklescript" [||];;

let () =
	init ();
	render ();;
