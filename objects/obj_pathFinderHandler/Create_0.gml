gridMap = ds_map_create();

breadthQueue = ds_queue_create();
cRoom = noone;
howOften = 60;
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
			if (!(j == 1 && i == 1)){
				
				var point = {square : collision_point(node.x+32*(i-1),node.y+32*(j-1),obj_gridSquare,false,false),distance : distance + 1 }
				if point.square != noone{
					var mapEntry = ds_map_find_value(gridMap,point.square.squareNo)
					if !mapEntry.visited && !point.square.isWall{
						ds_queue_enqueue(breadthQueue, point)
						mapEntry.visited = true;
						point.square.distance = distance+1
						
						
					}else if !point.square.isWall{
						if distance+1 < point.square.distance{
							
							point.square.distance = distance+1
						}
					}else if point.square.isWall && !mapEntry.visited{
						mapEntry.visited = true;
						point.square.distance = 999
						node.hasWallNeigh = true;
					}
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
	var entryInMap = ds_map_find_value(gridMap,entry.square.squareNo)
	entryInMap.visited = true;
	addNeighboursToQueue(entry.square,queue, entry.distance)
}

function getMovementCandidates(middle) {    
	var candidates = [];
    for (var i = 0; i < 3; i++) {
        for (var j =  0; j < 3; j++) {
            if (!(j == 1 && i == 1)) { //ignore middle
                var point = collision_point(middle.x+32*(i-1), middle.y+32*(j-1), obj_gridSquare, false, false);
                if (point != noone && !point.isWall) {
                    array_push(candidates,({
                        point: point,
                        distance: point.distance,
                        isDiagonal: (i != 1 && j != 1) // diagonal
                    }))
                }
            }
        }
    }
    return candidates;
}

function selectBestMove(candidates,middle) {
    // Sort by distance (ascending)
	array_sort(candidates, function(a, b) {
		if (a.distance < b.distance) return -1;
		if (a.distance > b.distance) return 1;
		return 0;
	});
    
    // Try candidates in order until we find a valid one
    for (var i = 0; i < array_length(candidates); i++) {
		var candidate = candidates[i];
        
		// If straight move (non-diagonal), always valid
		if (!candidate.isDiagonal) {
		    return candidate.point;
		}
        
		// For diagonal moves, check wall clipping
		if (!candidate.point.hasWallNeigh) {
		    return candidate.point;
		}
    }
    
    // If all diagonal moves are blocked, return closest (original behavior)
    return candidates.length > 0 ? candidates[0].point : noone;
}
function getNearestNeighbour2(middle){
	var candidates = getMovementCandidates(middle);
	var target = selectBestMove(candidates,middle);
	
	return target;
	
}
function getNearestNeighbour(middle){
	var minDistance = 9999;
	var nearestNeighbour = noone;
	for (var i = 0; i < 3; i++){
		for (var j = 0; j < 3; j++){
			if (!(j == 1 && i == 1)){
				var point = collision_point(middle.x+32*(i-1),middle.y+32*(j-1),obj_gridSquare,false,false)
				if point != noone{
					var dist = point.distance
					if dist < minDistance && !point.isWall{
						minDistance = dist;
						nearestNeighbour = point;
					}
				}
			}
		}
	}
	nearestNeighbour.lightUp = true;
	return nearestNeighbour;
}

function hasWallNeighbour(middle){
	for (var i = 0; i < 3; i++){
		for (var j = 0; j < 3; j++){
			if (!(j == 1 && i == 1)){
				var point = collision_point(middle.x+32*(i-1),middle.y+32*(j-1),obj_gridSquare,false,false)
				if point != noone{
					if point.isWall{
						return true
					}
				}
			}
		}
	}
	return false;
}

function checkOne(node, distance){
	if !node.square.isWall{
		if node.visited{
			
		}
	}
}

