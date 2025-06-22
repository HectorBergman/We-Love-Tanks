function initiateRoomHandler(){
	dungeonSize = 10; 
	currentRoom = [dungeonSize/2,dungeonSize/2];
	uniqueIDGiver = 0;
	dungeonGrid = ds_grid_create(dungeonSize, dungeonSize);
	allRooms = 0;
	roomList = noone;
	roomCoordsList = ds_list_create();
	roomList = ds_list_create();

	testEntity = noone;
	nextInstances = [];
	edgeList = ds_list_create();


	enteredRoomNo = 0;
	enteredDoorNo = 0;

	instancesLoaded = false;


	dungeon = generateDungeon();
	loadRoom();
	loadInPreviousObjects();
	instancesLoaded = true;
	var _room = ds_grid_get(obj_roomHandler.dungeonGrid, currentRoom[0], currentRoom[1])
	if !is_undefined(_room){
		_room.visited = true;
		if instance_number(obj_enemy) == 0 && instance_number(obj_enemySpawner) == 0{
			_room.cleared = true;
		}else{
			_room.cleared = false;
		}
	}
}
initiateRoomHandler();

function enterNewRoom(xDirection, yDirection,roomNo,doorNo){
	print("NEWROOM!")
	print("currentRoom: ");
	print(string(currentRoom[0]) + " + " + string(currentRoom[1]));
	print(roomNo);
	storePreviousRoom();
	if instance_number(obj_enemy) == 0 && instance_number(obj_enemySpawner) == 0{
		print("clear")
		ds_grid_get(dungeonGrid, currentRoom[0], currentRoom[1]).cleared = true;
	}else{
		print("notclear");
		ds_grid_get(dungeonGrid, currentRoom[0], currentRoom[1]).cleared = false;
	}
	print(enteredRoomNo);
	var extraDiff = getRoomDiff(enteredRoomNo,roomNo);
	print(extraDiff);
	enteredDoorNo = doorNo;
	currentRoom = [currentRoom[0]+xDirection+extraDiff[0],currentRoom[1]+yDirection+extraDiff[1]];
	print(currentRoom);
	var newRoom = ds_grid_get(dungeonGrid, currentRoom[0], currentRoom[1])
	if inRange(currentRoom[0], 0, dungeonSize) && inRange(currentRoom[1],0,dungeonSize) && !is_undefined(newRoom) && newRoom != noone{
		obj_currentRoomHandler.roomDoors = room_getAllDoors(newRoom);
		print(newRoom.doors);
		print(newRoom._room);
		gotoRoom(newRoom._room);
		enteredRoomNo = newRoom.roomShapeInfo.roomNo
	}else{
		currentRoom = [-229,-229];
		gotoRoom("error");
		print(currentRoom)
		print(newRoom);
		print("incomingerror");
	}
	isNewRoom = true;
}

function getRoomDiff(enterNo,exitNo){
	if enterNo == exitNo{
		return [0,0]
	}
	if enterNo == 0{
		if exitNo == 1{
			return [1,0]
		}else if exitNo == 2{
			return [0,1]
		}else if exitNo == 3{
			return [1,1]
		}
	}else if enterNo == 1{
		if exitNo == 0{
			return [-1,0]
		}else if exitNo == 2{
			return [-1,1]
		}else if exitNo == 3{
			return [0,1]
		}
	}else if enterNo == 2{
		if exitNo == 0{
			return [0,-1]
		}else if exitNo == 1{
			return [1,-1]
		}else if exitNo == 3{
			return [1,0]
		}
	}else if enterNo == 3{
		if exitNo == 0{
			return [-1,-1]
		}else if exitNo == 1{
			return [0,-1]
		}else if exitNo == 2{
			return [-1,0]
		}
	}
	return [0,0]
}

function loadInPreviousObjects(){
	var cRoom = ds_grid_get(dungeonGrid, currentRoom[0], currentRoom[1])
	print(cRoom);
	while !ds_list_empty(cRoom.roomShapeInfo.leftOverEntities){

		
		var currentEnt = ds_list_find_value(cRoom.roomShapeInfo.leftOverEntities,0);
		var names = variable_struct_get_names(currentEnt);

		for (var i = 0; i < array_length(names); i++){
			
			var name = names[i]
			names[i] = [name]
			names[i][1] = variable_struct_get(currentEnt,name)
			
		}
		var newEntity = summonObject(currentEnt.objIndex, names)
		ds_list_delete(cRoom.roomShapeInfo.leftOverEntities,0)
		
		
	}
}

function storePreviousRoom(){
	var cRoom = ds_grid_get(dungeonGrid, currentRoom[0], currentRoom[1])
	print(cRoom);
	for (var i = 0; i < instance_number(obj_enemy); i++){
		
		var currentInst = instance_find(obj_enemy,i);
		var newEntry = {objIndex:currentInst.object_index,x:currentInst.x,y:currentInst.y,hp:currentInst.hp,enemyType:currentInst.enemyType}
		ds_list_add(cRoom.roomShapeInfo.leftOverEntities,newEntry);
		
	}
	for (var i = 0; i < instance_number(obj_item); i++){
		var currentInst = instance_find(obj_item,i);
		if currentInst.state != itemState.collected{
			var newEntry =  {objIndex:currentInst.object_index,x:currentInst.x,y:currentInst.y,itemId:currentInst.itemId}
			ds_list_add(cRoom.roomShapeInfo.leftOverEntities,newEntry);
		}
	}
}

function gotoRoom(_room){
	obj_pathFinderHandler.isNewRoom = 2;
	if _room == "error"{
		room_goto(rm_errorRoom);
	}else{
	
	print(_room);

		
		nextInstances = _room.instances;
		print(_room.roomShape);
		room_goto(asset_get_index("rm_roomTemplate_" + _room.roomShape));
	//room_goto(rm_roomTemplate);
	}
	
}

function loadRoom(){
	isNewRoom = true;
	var insts = nextInstances
	for (var i = 0; i < array_length(insts); i++){
		print("---");
		print(insts[i]);
		summonObject(insts[i][0][1], insts[i]);
	}
}




//{"instances":[[["object","@ref object(obj_wall)"],["ownEditable",[]],["editable",[]],["x",400.0],["y",16.0],["image_xscale",1.0],["image_yscale",6.0]]],"roomName":""}] 
