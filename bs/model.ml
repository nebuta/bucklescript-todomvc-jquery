open Types
open ArrayOps
open Jquery

external stringify : todo array -> string = "JSON.stringify" [@@bs.val]
external setItem : string -> string -> unit = "localStorage.setItem" [@@bs.val]
external getItem : string -> string = "localStorage.getItem" [@@bs.val]
external parseJson : string -> todo array = "JSON.parse" [@@bs.val]

let calcIdx todos idx =
	Hashtbl.reset idx;
	let f i t =
		Hashtbl.add idx t.id i in
	Array.iteri f todos;;


let getFilteredTodos (filterType : filterType) (todos : todo array) : todo array =
	match filterType with
		All -> todos;
		| Active -> array_filter (fun x -> not x.completed) todos;
		| Completed -> array_filter (fun x -> x.completed) todos;;

let uuid () =
	let c i = string_of_int (Random.int 9) in
	let c8 i = String.concat "" (Array.to_list (Array.map c (array_range 8))) in
	String.concat "-" (Array.to_list @@ Array.map c8 (array_range 4))

let pluralize count word =
	if count <= 1 then word else word^"s"

let store_set namespace data =
	setItem namespace (stringify data);;

let store_get namespace =
	let store = getItem namespace in
	parseJson store
