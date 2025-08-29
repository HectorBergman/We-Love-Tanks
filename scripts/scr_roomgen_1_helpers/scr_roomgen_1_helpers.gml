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
function chebyshevDistance(startPoint,endPoint){
	return max(abs(startPoint[0]-endPoint[0]),abs(startPoint[1]-endPoint[1]));
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
function coordsWithinRange(argArray){
	var coord = argArray[0];
	var startCoords = argArray[1];
	var minimum = argArray[2];
	var maximum = argArray[3];
	return inRange(manhattanDistance(coord,startCoords), minimum, maximum)
}
function coordsWithinRangeChebyshev(argArray){
	var coord = argArray[0];
	var startCoords = argArray[1];
	var minimum = argArray[2];
	var maximum = argArray[3];
	return inRange(chebyshevDistance(coord,startCoords), minimum, maximum)
}




function setRandomCoordInArray(array, dfloor){
	var arrLen = array_length(array)
	if arrLen > 0{
		var randomIndex = irandom(arrLen-1);
		makeCoordsUnavailable(array[randomIndex],dfloor);
		return array[randomIndex];
	}else{
		forceCrash("No valid rooms!");
	}
}

function updateRoomsGridInfo(sRoom,coords){
	sRoom.gridInfo.isPlaced = true;
	sRoom.gridInfo.placedCoords = coords
}

function setAllRoomsAvailable(floorDimensions){
	var availableRooms = ds_map_create();
	for (var i = 0; i < floorDimensions[0]; i++){
		for (var j = 0; j < floorDimensions[1]; j++){
			ds_map_add(availableRooms, getCoordsString([i,j]), true);
		}
	}
	return availableRooms;
}

/// @function pickRandomRoomByType(roomArray, roomType)
/// @description Returns a RANDOM room struct where Type matches roomType
/// @param {array} roomArray   Array of room structs
/// @param {string} roomType   Type to filter by (e.g., "fun", "boss")
/// @returns {struct|undefined} Random room struct (or undefined if no matches)

function pickRandomRoomByType(roomArray, roomType, roomShape) {
    var matchingRooms = findRoomsByProperty(roomArray, "roomType", roomType);
    if (array_length(matchingRooms) == 0) {
        return undefined; // No matches found
    }
    var matchingRoomShapes = findRoomsByProperty(matchingRooms, "roomShape", roomShape);

    // Pick a random index from the filtered list
    var randomIndex = irandom(array_length(matchingRoomShapes) - 1);
	var newInstances = sanitizeRoomFromRoomData(matchingRoomShapes[randomIndex])

	matchingRoomShapes[randomIndex].instances = newInstances;

	return matchingRoomShapes[randomIndex];
}

/// @function findRoomsByProperty(roomArray, propertyName, targetValue)
/// @description Returns array of room names where the specified property matches targetValue
/// @param {array} roomArray     Array of room structs
/// @param {string} propertyName Property to check (e.g. "Type", "Difficulty")
/// @param {any} targetValue     Value to match (e.g. "undefined", "boss")
/// @returns {array<struct>} Matching room names

function findRoomsByProperty(roomArray, propertyName, targetValue) {
    var foundRooms = [];
    
    for (var i = 0; i < array_length(roomArray); i++) {
        var _room = roomArray[i];
        // Check if property exists AND matches targetValue
        if (variable_struct_exists(_room, propertyName) 
        && (variable_struct_get(_room, propertyName) == targetValue)) {
            array_push(foundRooms, _room); // If key is "Room_Name"
        }
    }
    return foundRooms;
}

function forceCrash(crashMessage){
	crashMessage = "ERROR: " + crashMessage
	print("--------------------------------")
	print(crashMessage);
	print("--------------------------------")
	crashMessage = crashMessage + 1;
}