dungeonSize = 10; 
currentRoom = [dungeonSize/2,dungeonSize/2];
uniqueIDGiver = 0;
dungeonGrid = ds_grid_create(dungeonSize, dungeonSize);
allRooms = 0;
roomList = noone;
roomList = ds_list_create();
dungeon = generateDungeon();
testEntity = noone;
isNewRoom = false;
nextInstances = [];



function enterNewRoom(xDirection, yDirection){
	storePreviousRoom();
	currentRoom = [currentRoom[0]+xDirection,currentRoom[1]+yDirection];
	var newRoom = ds_grid_get(dungeonGrid, currentRoom[0], currentRoom[1])
	if inRange(currentRoom[0], 0, dungeonSize) && inRange(currentRoom[1],0,dungeonSize) && !is_undefined(newRoom) && newRoom != noone{
		
		currentRoomHandler.roomDoors = newRoom.doors;
		print(newRoom.doors);
		print(newRoom._room)
		gotoRoom(newRoom._room);
	}else{
		currentRoom = [-666,-666];
		gotoRoom("error");
	}
	obj_player.x = obj_player.x-room_width*xDirection+(obj_player.sprite_width+32)*xDirection 
	obj_player.y = obj_player.y-room_height*yDirection+(obj_player.sprite_height+24)*yDirection 
	isNewRoom = true;
}

function loadInPreviousObjects(){
	var cRoom = ds_grid_get(dungeonGrid, currentRoom[0], currentRoom[1])
	while !ds_list_empty(cRoom.leftOverEntities){
		var currentEnt = ds_list_find_value(cRoom.leftOverEntities,0);
		var newEntity = summonObject(currentEnt.objIndex, [["x",currentEnt._x], ["y",currentEnt._y],["hp",currentEnt.hp],["enemyType",currentEnt.enemyType]])
		ds_list_delete(cRoom.leftOverEntities,0)
		
		
	}
}

function storePreviousRoom(){
	var cRoom = ds_grid_get(dungeonGrid, currentRoom[0], currentRoom[1])

	for (var i = 0; i < instance_number(obj_enemy); i++){

		var currentInst = instance_find(obj_enemy,i);
		var newEntry = {objIndex:currentInst.object_index,_x:currentInst.x,_y:currentInst.y,hp:currentInst.hp,enemyType:currentInst.enemyType}

		ds_list_add(cRoom.leftOverEntities,newEntry);
	}
}

function gotoRoom(_room){
	nextInstances = _room.instances;
	room_goto(rm_roomTemplate);
	//room_goto(rm_roomTemplate);
	
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
