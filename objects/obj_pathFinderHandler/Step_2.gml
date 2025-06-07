PAUSE
howOften--
timer--

var shallPass = false;

if editorException && timer < 1{
	shallPass = true
}else if instance_exists(obj_roomHandler){
	shallPass = currentRoom[0] != obj_roomHandler.currentRoom[0] && currentRoom[1] != obj_roomHandler.currentRoom[1] && timer < 1
}
if shallPass{
	print("wepassed");
	ds_map_clear(gridMap);
	for (var i = 0; i < instance_number(obj_gridSquare); i++){
		var unit = instance_find(obj_gridSquare,i)
		ds_map_add(gridMap, unit.squareNo, {square: unit, visited: false, distance: 0, visitedTwo: false})
	}
	BFS();
	if !editorException{
		currentRoom[0] = obj_roomHandler.currentRoom[0]
		currentRoom[1] = obj_roomHandler.currentRoom[1]
	}
	editorException = false;
}

if howOften < 0{
	howOften = 60;
	BFS();
	//BFS2();
}
/*if currentRoom[0] != obj_roomHandler.currentRoom[0] && currentRoom[1] != obj_roomHandler.currentRoom[1] && timer < 1{
	ds_map_clear(gridMap);
	for (var i = 0; i < instance_number(obj_gridSquare); i++){
		var unit = instance_find(obj_gridSquare,i)
		ds_map_add(gridMap, unit.squareNo, {square: unit, visited: false, distance: 0, visitedTwo: false})
	}
	BFS();
	currentRoom[0] = obj_roomHandler.currentRoom[0]
	currentRoom[1] = obj_roomHandler.currentRoom[1]
}

if howOften < 0{
	howOften = 60;
	BFS();
	//BFS2();
}