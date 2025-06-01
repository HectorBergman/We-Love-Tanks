PAUSE
howOften--
if cRoom != room{
	ds_map_clear(gridMap);
	for (var i = 0; i < instance_number(obj_gridSquare); i++){
		var unit = instance_find(obj_gridSquare,i)
		ds_map_add(gridMap, unit.squareNo, {square: unit, visited: false, distance: 0, visitedTwo: false})
	}
	BFS();
	cRoom = room;
}

if howOften < 0{
	howOften = 60;
	BFS();
	//BFS2();
}