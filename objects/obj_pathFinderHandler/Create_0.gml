pauseMode = [pM.editor, pM.pauseMenu]
gridMap = ds_map_create();

breadthQueue = ds_queue_create();
cRoom = noone;
howOften = 60;
closestToPlayer = noone;
timer = 5;
scale = 1;
currentRoom = [-1,-1]
visitNumber = 0;
bfsFinish = false;
editorException = false;
isNewRoom = 2;
newRoomLogic();
SignalSubscribe(id,"grid: newGridSpawned", function(){
	newRoomLogic();
});

function newRoomLogic(){
	ds_map_clear(gridMap);
	for (var i = 0; i < instance_number(obj_gridSquare); i++){
		var unit = instance_find(obj_gridSquare,i)
		ds_map_add(gridMap, unit.squareNo, {square: unit, visited: false, distance: 0, visitedTwo: false})
	}
	BFS();
	if !editorException{
		//currentRoom[0] = obj_roomHandler.currentRoom[0]
		//currentRoom[1] = obj_roomHandler.currentRoom[1]
	}
	editorException = false;
}

if obj_gameSettingHandler.gameState == gameStates.editorBuilding{
	editorException = true;
}

function resetNodes(){
	var first = ds_map_find_first(gridMap)
	ds_map_find_value(gridMap,first).visited = false;
	
	for (var i = 0; i < ds_map_size(gridMap)-1; i++){
		first = ds_map_find_next(gridMap, first);
		ds_map_find_value(gridMap,first).visited = false;
	}
}

function BFS(){
	/*var first = ds_map_find_first(gridMap)
	first = ds_map_find_next(gridMap,first)
	if (ds_map_find_value(gridMap,first).visited){
		resetNodes();
	}*/
	
	visitNumber = (visitNumber+1) mod 2;
	var closest = getClosestToPlayer();
	if closest != noone && !is_undefined(closest){
		addNeighboursToQueue(closest, breadthQueue,0)
	}
	
}

function continueBFS(){
	var maxPops = 50;
	var currentPops = 0;
	
	while !ds_queue_empty(breadthQueue) && currentPops < maxPops{
		popEntry(breadthQueue);
		currentPops++;
	}
}




function addNeighboursToQueue(node, queue, distance){
	if distance > 20{
		return
	}
	for (var i = 0; i < 3; i++){
		for (var j = 0; j < 3; j++){
			if (!(j == 1 && i == 1)){
				var point = {square : collision_point(node.x+32*(i-1)*scale,node.y+32*(j-1)*scale,obj_gridSquare,false,false),distance : distance + 1 }
				if point.square != noone{
					var mapEntry = ds_map_find_value(gridMap,point.square.squareNo)
					if !(mapEntry.visited == visitNumber) && !point.square.isWall{
						ds_queue_enqueue(breadthQueue, point)
						mapEntry.visited = visitNumber;
						point.square.distance = distance+1
						
						
					}else if !point.square.isWall{
						if distance+1 < point.square.distance{
							
							point.square.distance = distance+1
						}
					}else if point.square.isWall && !(mapEntry.visited == visitNumber){
						mapEntry.visited = visitNumber;
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
	with obj_player{
		instance_place_list(x,y,obj_gridSquare,closestList,true)
	}
	var closest = ds_list_find_value(closestList,0);
	return closest;
}

function popEntry(queue){
	var entry = ds_queue_dequeue(queue)
	var entryInMap = ds_map_find_value(gridMap,entry.square.squareNo)
	entryInMap.visited = visitNumber;
	addNeighboursToQueue(entry.square,queue, entry.distance)
}

function getMovementCandidates(middle) {    
	var candidates = [];
    for (var i = 0; i < 3; i++) {
        for (var j =  0; j < 3; j++) {
            if (!(j == 1 && i == 1)) { //ignore middle
                var point = collision_point(middle.x+32*(i-1)*scale, middle.y+32*(j-1)*scale, obj_gridSquare, false, false);
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
				var point = collision_circle(middle.x+32*(i-1)*scale,middle.y+32*(j-1)*scale, 32,obj_gridSquare,false,false)
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
				var point = collision_point(middle.x+32*(i-1)*scale,middle.y+32*(j-1)*scale,obj_gridSquare,false,false)
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
ds_queue_clear(breadthQueue);
