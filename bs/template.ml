open Types

let todoTemplate (todos : todo array) : string =
	let f todo =
	"<li data-id='"^todo.id^"'>
				<div class='view'>
					<input class='toggle' type='checkbox' "^(if todo.completed then "checked" else "")^">
					<label>"^todo.title^"</label>
					<button class='destroy'></button>
				</div>
				<input class='edit' value='as'>
			</li>" in
	String.concat "" (Array.to_list @@ Array.map f todos);;

let footerTemplate
	(activeTodoCount : int)
	(activeTodoWord : string)
	(completedTodoCount : int)
	(filter : string)
	: string =
	let sel_active n = if filter = n then "class='selected'" else "" in
	let ac = string_of_int activeTodoCount in
	let completedTodos = true in
	"<span id='todo-count'><strong>"^ac^"</strong> "^activeTodoWord^" left</span>
			<ul id='filters'>
				<li>
					<a "^(sel_active "all")^" href='#/all'>All</a>
				</li>
				<li>
					<a "^(sel_active "active")^" href='#/active'>Active</a>
				</li>
				<li>
					<a "^(sel_active "completed")^" href='#/completed'>Completed</a>
				</li>
			</ul>"^(if completedTodos then "<button id='clear-completed'>Clear completed</button>" else "")
		;;