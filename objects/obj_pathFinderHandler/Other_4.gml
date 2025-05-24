
for (var i = 0; i < instance_number(obj_gridSquare); i++){
	
	var unit = instance_find(obj_gridSquare,i)
	
	ds_map_add(gridMap, unit.squareNo, {square: unit, visited: false, distance: 0})
}
BFS();