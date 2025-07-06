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
    var matchingRooms = findRoomsByProperty(roomArray, "type", roomType);
    if (array_length(matchingRooms) == 0) {
        return undefined; // No matches found
    }

    var matchingRoomShapes = findRoomsByProperty(matchingRooms, "roomShape", roomShape);

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
	print("running: crownItemRoom");
	print("All items in edgeList: ")
	for (var i = 0; i < ds_list_size(edgeList); i++){
		var item = ds_list_find_value(edgeList,i);
		print("item number " + string(i) + ":");
		print(item)
		if item.edge != 1{
			print(item.edge)
			print("NOT AN EDGE IN EDGELIST!!!");
			print("NOT AN EDGE IN EDGELIST!!!");
			print("NOT AN EDGE IN EDGELIST!!!");
			print("NOT AN EDGE IN EDGELIST!!!");
			print("NOT AN EDGE IN EDGELIST!!!");
			print("NOT AN EDGE IN EDGELIST!!!");
			print("NOT AN EDGE IN EDGELIST!!!");
			print("NOT AN EDGE IN EDGELIST!!!");
			print("NOT AN EDGE IN EDGELIST!!!");
			print("NOT AN EDGE IN EDGELIST!!!");
			print("NOT AN EDGE IN EDGELIST!!!");
			print("NOT AN EDGE IN EDGELIST!!!");
			ds_list_delete(edgeList, find_room_index_by_coords(edgeList, item.coords));
			exit;
		}
		
	}
	var randomIndex = irandom(ds_list_size(edgeList)-1)
	var newList = ds_list_create();
	var finished = false;
	ds_list_copy(newList, edgeList);
	var chosenRoom = noone;
	var newRoom = noone;
	while !(finished || ds_list_empty(newList)){
		chosenRoom = ds_list_find_value(newList,randomIndex)
		var brandRoom = chosenRoom
		if !chosenRoom.amalgamated && chosenRoom.edge{
			newRoom = pickRandomRoomByType(global.roomList,"item", "normal")
			
			brandRoom._room = newRoom;
			brandRoom.roomType = "item"
			var ind = ds_list_find_index(edgeList, chosenRoom);
			ds_list_replace(edgeList, ind, brandRoom);
			finished = true;
			print("itemCoords:")
			print(brandRoom.coords);
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

function crownBossRoom(edgeList){
	var randomIndex = irandom(ds_list_size(edgeList)-1)
	var newList = ds_list_create();
	var finished = false;
	ds_list_copy(newList, edgeList);
	var chosenRoom = noone;
	var newRoom = noone;
	while !(finished || ds_list_empty(newList)){
		chosenRoom = ds_list_find_value(newList,randomIndex)
		var brandRoom = chosenRoom
		var emptyDoors = getEmptyDoors(chosenRoom);
		if !chosenRoom.amalgamated && array_length(emptyDoors) != 0 && chosenRoom.roomType == "standard" && chosenRoom.edge{
			newRoom = pickRandomRoomByType(global.roomList,"boss", "normal")
			
			brandRoom._room = newRoom;
			brandRoom.roomType = "boss"
			var doors = brandRoom.doors;
			var index1 = irandom(array_length(emptyDoors)-1)
			var newIndex = emptyDoors[index1] 
			doors[newIndex] = 2;
			brandRoom.doors = doors;
			var ind = ds_list_find_index(edgeList, chosenRoom);
			ds_list_replace(edgeList, ind, brandRoom);
			print("bossCoords:")
			print(brandRoom.coords);
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


function getEmptyDoors(_room){
	var returnArray = []
	var index = 0;
	for (var i = 0; i < 4; i++){
		
		if _room.doors[i] == 0{
			var xy = getXY(i);
			var adjacentRoom = ds_grid_get(dungeonGrid,_room.coords[0]+xy[0],_room.coords[1]+xy[1])

			if adjacentRoom == noone{

				returnArray[index] = i
				index++
			}
		}
		
	}

	return returnArray;
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

/// @function find_room_index_by_coords(room_list, target_coords)
/// @param {ds_list} room_list The list of room data structures to search through
/// @param {array} target_coords The [x,y] coordinates to search for (e.g., [2,2])
/// @returns {real} The index of the matching room, or -1 if not found

function find_room_index_by_coords(room_list, target_coords) {
	print("findroomindexbycoords:")
    var target_x = target_coords[0];
    var target_y = target_coords[1];
    print(target_coords);
	print("---");
    // Loop through all rooms in the list
    for (var i = 0; i < ds_list_size(room_list); i++) {
        var _room = ds_list_find_value(edgeList,i);
    
        var room_coords = _room.coords;
		print(room_coords);
            
 
        if (room_coords[0] == target_x && room_coords[1] == target_y) {
			print("w");
            return i; // Found matching room
        }
        
    }
    print("fail");
    return -1; // No matching room found
}