/// @function findRoomsByProperty(roomArray, propertyName, targetValue)
/// @description Returns array of room names where the specified property matches targetValue
/// @param {array} roomArray     Array of room structs
/// @param {string} propertyName Property to check (e.g. "Type", "Difficulty")
/// @param {any} targetValue     Value to match (e.g. "undefined", "boss")
/// @returns {array} Matching room names

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


/// @function pickRandomRoomByType(roomArray, roomType)
/// @description Returns a RANDOM room struct where Type matches roomType
/// @param {array} roomArray   Array of room structs
/// @param {string} roomType   Type to filter by (e.g., "fun", "boss")
/// @returns {struct|undefined} Random room struct (or undefined if no matches)

function pickRandomRoomByType(roomArray, roomType, roomShape) {
	print("penis1");
	print(roomArray);
    var matchingRooms = findRoomsByProperty(roomArray, "type", roomType);
    if (array_length(matchingRooms) == 0) {
        return undefined; // No matches found
    }
	print(matchingRooms);
    var matchingRoomShapes = findRoomsByProperty(matchingRooms, "roomShape", roomShape);
	print("shapes");
	print(matchingRoomShapes);
    // Pick a random index from the filtered list
    var randomIndex = irandom(array_length(matchingRoomShapes) - 1);
    return matchingRoomShapes[randomIndex];
}

function isEdge(doors){
	var doorCount = 0;
	for (var i = 0; i < 4; i++){
		if doors[i] == 1{
			doorCount++
		}
	}
	return doorCount == 1
}
 //hello me from the future. too much shit to do in your mf dungeon?
 // method_call(processCellFunc, [(params)])
 //take this, and create an array of touple pairs of function and params and loop through the array.
 //good luck brah. i aint doin allat 100 im hardcoding that shi lmfaoooo
function loopThroughDungeon(dungeonList){
	var edgeList = ds_list_create()
	for (var i = 0; i < ds_list_size(dungeonList); i++){
		addIfEdge(dungeonList,i,edgeList);
		
	}
	crownItemRoom(edgeList);
}

function addIfEdge(list,index, toAdd){
	var value = ds_list_find_value(list, index)
	if (value.edge){
		ds_list_add(toAdd,value);
	}
}

function crownItemRoom(edgeList){
	var randomIndex = irandom(ds_list_size(edgeList)-1)
	var newList = ds_list_create();
	var finished = false;
	ds_list_copy(newList, edgeList);
	var chosenRoom = noone;
	var newRoom = noone;
	while !(finished || ds_list_empty(newList)){
		chosenRoom = ds_list_find_value(newList,randomIndex)
		var brandRoom = chosenRoom
		print(chosenRoom);
		print(pickRandomRoomByType(global.roomList,"item", "normal"));
		if !chosenRoom.amalgamated{
			newRoom = pickRandomRoomByType(global.roomList,"item", "normal")
			brandRoom._room = newRoom;
			var ind = ds_list_find_index(edgeList, chosenRoom);
			ds_list_replace(edgeList, ind, brandRoom);
			finished = true;
		}else{
			ds_list_delete(newList,randomIndex);
		}
	}
	if !finished{
		print("fuck,lol");
	}else{
		print("chosenROom")
		print(chosenRoom);
		print("newRoom");
		print(newRoom);
	}
}

function getRoomShapeTable(roomShape){
	if roomShape == "normal"{
		return [1,0,0,0];
	}else if roomShape == "tall"{
		return [1,0,1,0];
	}else if roomShape == "long"{
		return [1,1,0,0];
	}else if roomShape == "topLeftAbsent"{
		return [0,1,1,1];
	}else if roomShape == "topRightAbsent"{
		return [1,0,1,1];
	}else if roomShape == "bottomLeftAbsent"{
		return [1,1,0,1];
	}else if roomShape == "bottomRightAbsent"{
		return [1,1,1,0];
	}else if roomShape == "giant"{
		return [1,1,1,1];
	}else{
		return [1,0,0,0]
	}
}