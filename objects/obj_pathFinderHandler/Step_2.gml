
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
}*/
