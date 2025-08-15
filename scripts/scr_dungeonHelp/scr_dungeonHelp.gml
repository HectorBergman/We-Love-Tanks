#macro dungeonLimits [0,9]

/// @function findRoomsByProperty(roomArray, propertyName, targetValue)
/// @description Returns array of room names where the specified property matches targetValue
/// @param {array} roomArray     Array of room structs
/// @param {string} propertyName Property to check (e.g. "Type", "Difficulty")
/// @param {any} targetValue     Value to match (e.g. "undefined", "boss")
/// @returns {array<struct>} Matching room names

function findRoomsByProperty(roomArray, propertyName, targetValue) {
    var foundRooms = [];
	print("findRoomsByProperty");
    
    for (var i = 0; i < array_length(roomArray); i++) {
        var _room = roomArray[i];
		print("room number " + string(i));
		print(_room);
        // Check if property exists AND matches targetValue
        if (variable_struct_exists(_room, propertyName) 
        && (variable_struct_get(_room, propertyName) == targetValue)) {
            array_push(foundRooms, _room); // If key is "Room_Name"
        }
    }
    print("foundROoms: " + string(foundRooms));
    return foundRooms;
}


/// @function pickRandomRoomByType(roomArray, roomType)
/// @description Returns a RANDOM room struct where Type matches roomType
/// @param {array} roomArray   Array of room structs
/// @param {string} roomType   Type to filter by (e.g., "fun", "boss")
/// @returns {struct|undefined} Random room struct (or undefined if no matches)

function pickRandomRoomByType(roomArray, roomType, roomShape) {
	print("roomarr")
	print(roomArray);
    var matchingRooms = findRoomsByProperty(roomArray, "roomType", roomType);
    if (array_length(matchingRooms) == 0) {
        return undefined; // No matches found
    }
    var matchingRoomShapes = findRoomsByProperty(matchingRooms, "roomShape", roomShape);

    // Pick a random index from the filtered list
    var randomIndex = irandom(array_length(matchingRoomShapes) - 1);
	var newInstances = sanitizeRoomFromRoomData(matchingRoomShapes[randomIndex])
	print("newinstances")
	print(newInstances);
	matchingRoomShapes[randomIndex].instances = newInstances;
	print("therooM");
	print(matchingRoomShapes[randomIndex]);
	return matchingRoomShapes[randomIndex];
}
/*[{"instances":
	[{"summonArr":
		[["image_xscale",1.0],
		["image_yscale",1.0],["x",368.0],["y",96.0],
		["sprite_index","@ref sprite(spr_enemySpawner)"],
		["heldOffset",[0.0,0.0]],["depth",-260.0],["canResize",false],
		["held",false]],"displayObjIndex":4.0,
		"instanceArgumentsChoices":["stiffRicochet"]},
	{"summonArr":
		[["image_xscale",1.0],["image_yscale",1.0],
		 ["x",336.0],["y",96.0],["sprite_index","@ref sprite(spr_enemySpawner)"],
		 ["heldOffset",[0.0,0.0]],["depth",-260.0],
		 ["canResize",false],["held",false]],
		 "displayObjIndex":4.0,"instanceArgumentsChoices":["stiffNormal"]},
"roomShape":"normal",
"roomType":"standard",
"savedRandomsNeeded":5.0,
"roomName":"balls"}*/

function sanitizeRoomFromRoomData(_room, index){
	print("test");
	print(_room);
	var newInstancesArr = [];
	if variable_struct_exists(_room,"sanitized"){
		print("passed")
		return _room.instances;
	}
	print("nopass");
	for (var i = 0; i < array_length(_room.instances); i++){
		print("togo");
		print(_room.instances);
		var inst = _room.instances[i];
		print("lol");
		print(inst);
		var summonArr = getSummonArrFromChoices(inst.displayObjIndex, inst.instanceArgumentsChoices);
		print("fuckyase");
		print(summonArr)
		print("--");
		var newSummonArr = array_concat(inst.summonArr,summonArr);
		print(newSummonArr);
		var newInst = {objectIndex : ds_list_find_value(global.displayObjects,inst.displayObjIndex).objectIndex,
					   summonArray : newSummonArr}
		newInstancesArr[i] = newInst;
						
		//insts[i] = 
	}
	print("sanitized")
	_room.sanitized = true;
	//insts[i][0][1], insts[i]
	return newInstancesArr;
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
		print(ds_list_size(newList))
		print(randomIndex);
		if !chosenRoom.amalgamated{
			newRoom = pickRandomRoomByType(global.roomList,"item", "normal")
			
			brandRoom._room = newRoom;
			brandRoom.roomType = "item"
			var ind = ds_list_find_index(edgeList, chosenRoom);
			print("roomReplaced:");
			print(ds_list_find_value(edgeList, ind).coords);
			ds_list_delete(edgeList, ind);
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

function crownBossRoom(edgeList){
	var roomType = "boss"
	var randomIndex = 0
	var finished = false;
	var newList = edgeList;
	var chosenRoom = noone;
	var newRoom = noone;
	while !(finished || ds_list_empty(newList)){
		print("edgeliste:")
		print("----------");
		for (var i = 0; i < ds_list_size(edgeList); i++){
			print(ds_list_find_value(edgeList,i));
		}
		randomIndex = irandom(ds_list_size(newList)-1)
		chosenRoom = ds_list_find_value(newList,randomIndex)
		var brandRoom = chosenRoom
		print("-----");
		print(ds_list_size(newList));
		print(randomIndex)
		print(chosenRoom);
		print(pickRandomRoomByType(global.roomList,roomType, "normal"));
		var emptyDoors = getEmptyDoors(chosenRoom);
		if !chosenRoom.amalgamated && array_length(emptyDoors) != 0 && chosenRoom.roomType == "standard"{
			newRoom = pickRandomRoomByType(global.roomList,roomType, "normal")
			
			brandRoom._room = newRoom;
			brandRoom.roomType = roomType
			var doors = brandRoom.doors;
			var index1 = irandom(array_length(emptyDoors)-1)
			var newIndex = emptyDoors[index1] 
			doors[newIndex] = 2;
			brandRoom.doors = doors;
			var ind = ds_list_find_index(edgeList, chosenRoom);
			print("roomReplaced:");
			print(ds_list_find_value(edgeList, ind).coords);
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


function getEmptyDoors(_room){
	var returnArray = []
	var index = 0;
	print("emptyDoors")
	print(_room);
	for (var i = 0; i < 4; i++){
		
		if _room.doors[i] == 0{
			var xy = getXY(i);
			var adjacentRoom = ds_grid_get(dungeonGrid,_room.coords[0]+xy[0],_room.coords[1]+xy[1])
			print(adjacentRoom)
			if adjacentRoom == noone{
				print("wegotpast");
				returnArray[index] = i
				index++
			}
		}
		
	}
	print(returnArray);
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