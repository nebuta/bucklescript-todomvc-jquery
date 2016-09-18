
let array_append e arr =
	arr.(Array.length arr) <- e;;

let array_filter pred arr =
	let ret = [||] in
	let f x =
		if pred x then
			array_append x ret;
	in
	Array.iter f arr;
	ret

let array_splice i arr =
	let a1 = Array.sub arr 0 i in
	let a2 = Array.sub arr (i+1) (Array.length arr - i - 1) in
	Array.append a1 a2

let array_range n =
	let arr = Array.make n 0 in
	for i=0 to (n-1) do
		arr.(i) <- i
	done;
	arr;;


let findi a pred =
  let rec findi a pred n =
    if pred a.(n) then Some n
    else findi a pred (n+1)
  in
  try 
    findi a pred 0
   with _ -> None
;;