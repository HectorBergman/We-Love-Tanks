#macro dungeonLimits [0,9]




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

	var newInstancesArr = [];
	if variable_struct_exists(_room,"sanitized"){
		return _room.instances;
	}
	for (var i = 0; i < array_length(_room.instances); i++){
		
		var inst = _room.instances[i];

		var summonArr = getSummonArrFromChoices(inst.displayObjIndex, inst.instanceArgumentsChoices);
		var newSummonArr = array_concat(inst.summonArr,summonArr);
		var newInst = {objectIndex : ds_list_find_value(global.displayObjects,inst.displayObjIndex).objectIndex,
					   summonArray : newSummonArr}
		newInstancesArr[i] = newInst;
						
		//insts[i] = 
	}
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
		if !chosenRoom.amalgamated{
			newRoom = pickRandomRoomByType(global.roomList,"item", "normal")
			
			brandRoom._room = newRoom;
			brandRoom.roomType = "item"
			var ind = ds_list_find_index(edgeList, chosenRoom);
			ds_list_delete(edgeList, ind);
			finished = true;
		}else{
			ds_list_delete(newList,randomIndex);
		}
	}
	if !finished{
		print("failed finding ITEM ROOM");
	}else{

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
		randomIndex = irandom(ds_list_size(newList)-1)
		chosenRoom = ds_list_find_value(newList,randomIndex)
		var brandRoom = chosenRoom
		var emptyDoors = getEmptyDoors(chosenRoom);
		if !chosenRoom.amalgamated && array_length(emptyDoors) != 0 && chosenRoom.roomType == "standard"{
			newRoom = pickRandomRoomByType(global.roomList,roomType, "normal")
			
			brandRoom._room = newRoom;
			brandRoom.roomType = roomType
			var doors = brandRoom.doors;
			var index1 = irandom(array_length(emptyDoors)-1)
			var newIndex = emptyDoors[index1] 
			doors[newIndex] = doorValues.openToNewStage;
			brandRoom.doors = doors;
			var ind = ds_list_find_index(edgeList, chosenRoom);
			ds_list_replace(edgeList, ind, brandRoom);
			finished = true;
		}else{
			ds_list_delete(newList,randomIndex);
		}
	}
	if !finished{
		print("failed finding BOSS ROOM");
	}else{
	}
}

function crownShopRoom(edgeList){
	var randomIndex = 0
	var finished = false;
	var newList = edgeList;
	var chosenRoom = noone;
	var newRoom = noone;
	while !(finished || ds_list_empty(newList)){
		randomIndex = irandom(ds_list_size(newList)-1)
		chosenRoom = ds_list_find_value(newList,randomIndex)
		var brandRoom = chosenRoom
		var emptyDoors = getEmptyDoors(chosenRoom);
		if array_length(emptyDoors) != 0 && chosenRoom.roomType == "standard"{//todo: amalgamte
			var doors = brandRoom.doors;
			var index1 = irandom(array_length(emptyDoors)-1)
			var newIndex = emptyDoors[index1] 
			doors[newIndex] = doorValues.openToShop;
			var ind = ds_list_find_index(edgeList, chosenRoom);
			print(ds_list_find_value(edgeList, ind).coords);
			finished = true;
		}else{
			ds_list_delete(newList,randomIndex);
		}
	}
	if !finished{
		print("failed finding SHOP");
	}
}

function getEmptyDoors(_room){
	var returnArray = []
	var index = 0;

	for (var i = 0; i < 4; i++){
		
		if _room.doors[i] == 0{
			var xy = getXY(i);
			var adjacentRoom = ds_grid_get(dungeonGrid,_room.coords[0]+xy[0],_room.coords[1]+xy[1])
			print(adjacentRoom)
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