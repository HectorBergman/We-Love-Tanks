gridMap = ds_map_create();

breadthQueue = ds_queue_create();

howOften = 5;
closestToPlayer = noone;

function resetNodes(){
	var first = ds_map_find_first(gridMap)
	ds_map_find_value(gridMap,first).visited = false;

	for (var i = 0; i < ds_map_size(gridMap)-1; i++){
		first = ds_map_find_next(gridMap, first);
		ds_map_find_value(gridMap,first).visited = false;
	}
}

function BFS(){
	var first = ds_map_find_first(gridMap)
	first = ds_map_find_next(gridMap,first)
	if (ds_map_find_value(gridMap,first).visited){
		print("resetting!");
		resetNodes();
	}
	addNeighboursToQueue(getClosestToPlayer(), breadthQueue,0)
	while !ds_queue_empty(breadthQueue){
		popEntry(breadthQueue);
	}
}
function addNeighboursToQueue(node, queue, distance){
	for (var i = 0; i < 3; i++){
		for (var j = 0; j < 3; j++){
			var point = {square : collision_point(node.x+32*(i-1),node.y+32*(j-1),obj_gridSquare,false,false),distance : distance + 1}
			if point.square != noone{
				var mapEntry = ds_map_find_value(gridMap,point.square.squareNo)
				if !mapEntry.visited && !point.square.isWall{
					mapEntry.visited = true;
					point.square.distance = point.distance
					ds_queue_enqueue(breadthQueue, point)
				}
			}
		}
	}
}

function getClosestToPlayer(){
	var closestList = ds_list_create();
	with playerTank{
		instance_place_list(x,y,obj_gridSquare,closestList,true)
	}
	var closest = ds_list_find_value(closestList,0);
	return closest;
}

function popEntry(queue){
	var entry = ds_queue_dequeue(queue)
	print("penisssese");
	print(entry);
	var entryInMap = ds_map_find_value(gridMap,entry.square.squareNo)
	entryInMap.visited = true;
	addNeighboursToQueue(entry.square,queue, entry.distance)
}



function checkOne(node, distance){
	if !node.square.isWall{
		if node.visited{
			
		}
	}
}

