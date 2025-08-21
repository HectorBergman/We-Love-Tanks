function coordsWithinGrid(coords,gridDimensions){
	return !(
			 coords[0] >= gridDimensions[0] || 
			 coords[0] < 0 || 
			 coords[1] >= gridDimensions[1]	|| 
			 coords[1] < 0
			)
}
function getCoordsString(coords){
	return string(coords[0]) + "," + string(coords[1]);
}
function makeCoordsUnavailable(coords,dfloor){
	var coordsString = getCoordsString(coords);
	var coordValue = ds_map_find_value(dfloor.availableCoords, coordsString)
	if !is_undefined(coordValue) && coordValue{
		print("made unavailable: " + coordsString); //deletePrint
		ds_map_set(dfloor.availableCoords, coordsString, false)
	}else{
		print(coordsString);
		print(coordValue)
		forceCrash("setUnavailableCoords: coords not valid or already unavailable")
	}
}
function coordsAreAvailable(unavailableRooms, coordStr){
	return ds_map_find_value(availableRooms, coordStr)
}
function manhattanDistance(startPoint,endPoint){
	return abs(startPoint[0]-endPoint[0])+abs(startPoint[1]-endPoint[1]);
}
function getCoordsFromString(coordsString){
	var pos = string_pos(",", coordsString)
	var coord1 = string_copy(coordsString,0,pos-1)
	var coord2 = string_copy(coordsString,pos+1,string_length(coordsString)-pos);
	var num1 = real(coord1);
	var num2 = real(coord2);
	return [num1,num2];
}
function generateDistanceFromStartRequirement(startPoint,minDistance,maxDistance){
	return {
		requirementFunction: function(arg){return true}, 
		extraArguments: [startPoint,minDistance,maxDistance]
	}
}
//requirementfunc: true if requirement met
function getAllAvailableCoordsFittingReq(dfloor,requirement){
	var arr = [];
	var map = dfloor.availableCoords
	var current = ds_map_find_first(map)
	var arrIndex = 0;
	for (var i = 0; i < ds_map_size(map); i++){
		if ds_map_find_value(map,current){
			var coord = getCoordsFromString(current);
			if requirement.requirementFunction(array_concat([[coord[0],coord[1]]],requirement.extraArguments)){
				arr[arrIndex] = coord;
				arrIndex++
			}
		}
		current = ds_map_find_next(map, current);
	}
	return arr;
}
//coord, startCoords, minimum, maximum
function coordWithinRange(argArray){
	var coord = argArray[0];
	var startCoords = argArray[1];
	var minimum = argArray[2];
	var maximum = argArray[3];
	return inRange(manhattanDistance(coord,startCoords), minimum, maximum)
}



function setRandomCoordInArray(array, dfloor){
	var randomIndex = irandom(array_length(array)-1);
	makeCoordsUnavailable(array[randomIndex],dfloor);
	return array[randomIndex];
}

function forceCrash(crashMessage){
	crashMessage = "ERROR: " + crashMessage
	print("--------------------------------")
	print(crashMessage);
	print("--------------------------------")
	crashMessage = crashMessage + 1;
}