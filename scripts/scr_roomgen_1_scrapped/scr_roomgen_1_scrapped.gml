
function findClosestCoordinate(coord,array){
	var closestCoord = [-1,-1]
	var closestDistance = 999999;
	for (var i = 0; i < array_length(array); i++){
		var coordinate = array[i];
		var distance = manhattanDistance(coord,coordinate);
		if closestDistance > distance{
			closestDistance = distance;
			closestCoord = coordinate;
		}
	}
	if closestCoord[0] == -1{
		print(closestCoord);
		print(closestDistance)
		print(array);
		forceCrash("findClosestCoordinate: array empty or otherwise closest coord not found!");
	}
	return closestCoord;
}


function getNeighboursExist(dfloor, coords){
	var neighbours = [];
	for (var i = 0; i < 4; i++){
		var dir = i;
		var XY = getXY(i);
		if coordsWithinGrid([coords[0]+XY[0],coords[1]+XY[1]], dfloor.dimensions) && 
		   roomExists(ds_grid_get(dfloor.grid, coords[0]+XY[0],coords[1]+XY[1])){
			neighbours[i] = true //do stuff here with doors and crap
		}else{
			neighbours[i] = false
		}
	}
}


function roomHasSpecialInfo(_room){
	return !_room.specialInfo == noone;
}


function doorIsIllegitimate(dfloor,_room,doorDir){
	var XY = getXY(doorDir);
	if !coordsWithinGrid([_room.coords[0]+XY[0],_room.coords[1]+XY[1]],dfloor.dimensions){
			return true;
	}
	return false;
}

function findIllegitimateDoors(dfloor,_room){
	var coords = _room.coords;
	var bannedDoors = [];
	var index = 0;
	for (var i = 0; i < 4; i++){
		var XY = getXY(i);

		if !coordsWithinGrid([coords[0]+XY[0],coords[1]+XY[1]],dfloor.dimensions){
			bannedDoors[index] = i
			index++
		}
	}
	return bannedDoors;
}

function averageRoomOffspring(dfloor){
	var weight = dfloor.doorWeights
	var weightSum = 0;
	var totalDoors = 0;
	for (var i = 1; i < array_length(weight); i++){
		weightSum += weight[i];
		totalDoors += weight[i]*(i-1);
	}
	return totalDoors/weightSum
}

