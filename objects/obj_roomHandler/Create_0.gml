pauseMode = [pM.pauseMenu];
global.newRoom = true;
enterInfo = {
	enteredRoomCoords: [-1,-1], 
	enteredRoomDoor: 0,
	enteredRoomNo: 0,
	enteredRoomDir: [-1,-1]
}

SignalSubscribe(id, "roomEntered: newRoom", roomEnterLogic);
SignalSubscribe(id, "roomEntered: shop", shopEnterLogic);
SignalSubscribe(id, "roomExit: shop", shopExitLogic);
function initiateRoomHandler(){
	totalDungeon = [];
	global.currentSeed = global.dungeonSeed;
	random_set_seed(global.currentSeed);
	print("GENERATING NEW DUNGEON...")
	print("SEED: " + string(global.currentSeed));
	dungeonSize = 10; 
	currentRoom = [dungeonSize/2,dungeonSize/2];
	dungeonGrid = ds_grid_create(dungeonSize, dungeonSize);


	testEntity = noone;
	nextInstances = [];
	edgeList = ds_list_create();

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
	global.dungeonSeed = irandom_range(0, 4294967295)
	randomize();
	global.currentSeed = random_get_seed();
}
initiateRoomHandler();

SignalSubscribe(id,"transportRoom",function(arg){
	enterNewRoom(arg[0],arg[1],arg[2],arg[3]);
});

SignalSubscribe(id, "transportShop", function(arg){
	enterShop(arg[0],arg[1],arg[2]);
});
function enterShop(){
	print("enterShoP!"); //x
	storePreviousRoom();
	room_goto(rm_menu_shop);
}


function enterNewRoom(xDirection, yDirection,roomNo,doorNo){

	global.newRoom = true;
	storePreviousRoom();
	if instance_number(obj_enemy) == 0 && instance_number(obj_enemySpawner) == 0{
		ds_grid_get(dungeonGrid, currentRoom[0], currentRoom[1]).cleared = true;
	}else{
		ds_grid_get(dungeonGrid, currentRoom[0], currentRoom[1]).cleared = false;
	}
	var extraDiff = getRoomDiff(enterInfo.enteredRoomNo,roomNo);
	enterInfo.enteredRoomDoor = doorNo;
	currentRoom = [currentRoom[0]+xDirection+extraDiff[0],currentRoom[1]+yDirection+extraDiff[1]];
	var newRoom = ds_grid_get(dungeonGrid, currentRoom[0], currentRoom[1])
	if inRange(currentRoom[0], 0, dungeonSize) && inRange(currentRoom[1],0,dungeonSize) && !is_undefined(newRoom) && newRoom != noone{
		obj_currentRoomHandler.roomDoors = room_getAllDoors(newRoom);
		gotoRoom(newRoom._room);
		enterInfo.enteredRoomNo = newRoom.roomShapeInfo.roomNo
	}else{
		currentRoom = undefinedCoords;
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
	print("loadInpreviousobj");
	var cRoom = ds_grid_get(dungeonGrid, currentRoom[0], currentRoom[1])
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


function gotoRoom(_room){
	obj_pathFinderHandler.isNewRoom = 2;
	if _room == "error"{
		room_goto(rm_errorRoom);
	}else{
		nextInstances = _room.instances;
		room_goto(asset_get_index("rm_roomTemplate_" + _room.roomShape));
	//room_goto(rm_roomTemplate);
	}
	
}

function loadRoom(){
	isNewRoom = true;
	var insts = nextInstances
	for (var i = 0; i < array_length(insts); i++){
		summonObject(insts[i].objectIndex, insts[i].summonArray);
	}
}


function roomEnterLogic(){
	loadInPreviousObjects();
	loadRoom();
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

function shopEnterLogic(xDirEnteredFrom,yDirEnteredFrom,roomEnteredFrom,doorNoEnteredFrom){
	global.shop = true;
	summonObject(obj_shopHandler, [[]]);
	SignalSend("shop: prevRoomInfo", [
			[currentRoom[0], currentRoom[1]],
			[xDirEnteredFrom,yDirEnteredFrom],
			roomEnteredFrom,
			doorNoEnteredFrom
		]
	)
	summonObject(obj_editor_pointer);
	print("inShop!!!!=)"); //x
	SignalSubscribe(id, "shop: exitInfo", function(arg){
		enterNewRoom(xDirection, yDirection,roomNo,doorNo)
	})
}
function shopExitLogic(){
	print("exitingshop..");
	
	SignalSend("shopHandler: exit");
	global.shop = false;
	SignalUnsubscribe(id, "shop: exitInfo");
}

//{"instances":[[["object","@ref object(obj_wall)"],["ownEditable",[]],["editable",[]],["x",400.0],["y",16.0],["image_xscale",1.0],["image_yscale",6.0]]],"roomName":""}] 
