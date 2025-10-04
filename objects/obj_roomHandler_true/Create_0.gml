pauseMode = [pM.pauseMenu];
global.newRoom = true;
enterInfo = {
	enteredRoomCoords: [-1,-1], 
	enteredRoomDoor: 0,
	enteredRoomNo: 0,
	enteredRoomDir: [-1,-1]
}
currentDungeon = noone;
currentFloor = noone;
currentRoom = noone;
function newDungeon(){
	with (obj_roomHandler_true){
		var startPoint = [1,1]
		var spezRooms = [
			createSpecialRoom("item", posRequirement(coordsWithinRangeChebyshev_edgesOnly,[startPoint, 0,3])),
			createSpecialRoom("boss", posRequirement(coordsWithinRangeChebyshev_edgesOnly,[startPoint, 0,3]))
		]
		floorReqs = ds_list_create()
		var oneReq = floorRequirements([3,3],startPoint,0.1,[[0,0,4,2,1], [0,0.5,4,1,1], [0,1,2,2,1], [0,1,4,1,0.5], [0,1.1,0.5,0,0]],[4,8],spezRooms)
		SignalSubscribe(id,"roomEntered: general", function(){
			if enteredDoor != -1{
				SignalSend("roomEntranceNo", (enteredDoor+2) mod 4);
			}
			SignalSend("clearedStatus", currentRoom.cleared);
			loadRoom(currentRoom)
		})
		ds_list_add(floorReqs, oneReq);
		ds_list_add(floorReqs, oneReq);
		currentDungeon = initiateDungeon(floorReqs);
		currentFloor = changeFloor(currentDungeon, 0)
		currentRoom = ds_grid_get(currentFloor.grid, currentFloor.startPoint[0],currentFloor.startPoint[1])
		minimapFullUpdate()
	}
}
enteredDoor = -1
newDungeon()
SignalSubscribe(id,"transportRoom",function(arg){
	enterNewRoom(arg.diff,arg.roomNo,arg.doorNo,arg.store);
});
SignalSubscribe(id, "Boss defeated", summonDungeonTrans);
SignalSubscribe(id,"newDungeon",  nextLvl)
SignalSubscribe(id,"minimap", minimapFullUpdate)

function minimapFullUpdate(){
	SignalSend("update: currentDungeon", currentDungeon)
	SignalSend("update: currentFloor", currentFloor)
	SignalSend("update: currentRoom", currentRoom)
	SignalSend("update: minimap")
}

function nextLvl(){
	newDungeon()
	SignalSend("transitionStart", {
		transitionType: transitionTypes.newDungeon, 
		transitionStruct : {
						diff: [0,0],
						roomNo:0,
						doorNo:-1, 
						movementVector: [0,0],
						store: false
					},
		transitionLengthMult : 3
	})
	print(currentRoom)
}

function enterNewRoom(dir,roomNo,doorNo, store = true){
	if store{
		storePreviousRoom([
			{oIndex: obj_enemy, variables:["x","y","hp","enemyType"]},
			{oIndex: obj_item, variables:["x","y","itemId","state"]},
			{oIndex: obj_dollar, variables:["x","y","scale","type","z","image_angle",
				"rotation","velocity","zSpeed","movementVector","dollarState","coinState",
				"swayX","swayY","timer","movementVectorSway","featherDir","featherVelocity",
				"fakeX","fakeY"]},
			{oIndex: obj_dungeonTrans, variables:["x","y"]},
			{oIndex: obj_boss, variables:["x","y","hp","phase","type","movementVector"]}
		]);
		checkCleared()
	}
	enteredDoor = doorNo;
	currentRoom.visited = true;
	//var extraDiff = getRoomDiff(enterInfo.enteredRoomNo,roomNo);
	//enterInfo.enteredRoomDoor = doorNo;
	var newCoords = [currentRoom.coords[0]+dir[0], currentRoom.coords[1]+dir[1]]//+extraDiff[0],currentRoom[1]+yDirection+extraDiff[1]];
	var newRoom = ds_grid_get(currentFloor.grid, newCoords[0], newCoords[1])
	if inRange(newCoords[0], 0, currentFloor.dimensions[0]) && inRange(newCoords[1], 0, currentFloor.dimensions[1]) && !is_undefined(newRoom) && newRoom != noone{
		//obj_currentRoomHandler.roomDoors = room_getAllDoors(newRoom);
		gotoRoom(newRoom);
		currentRoom = newRoom
		//enterInfo.enteredRoomNo = newRoom.roomShapeInfo.roomNo
	}else{
		currentRoom = undefinedCoords;
		forceCrash("roomOutsideBoundaries");
		//todo: add error room
	}
	SignalSend("update: currentRoom", currentRoom)
	SignalSend("update: minimap")
	//isNewRoom = true;
}

function gotoRoom(_room){
	print("wegotoroom");
	room_goto(asset_get_index("rm_roomTemplate_" + _room.roomShape[0]));
}

function storePreviousRoom(objectIndexes){
	var cRoom = ds_grid_get(currentFloor.grid, currentRoom.coords[0], currentRoom.coords[1])
	for (var i = 0; i < array_length(objectIndexes); i++){
		for (var j = 0; j < instance_number(objectIndexes[i].oIndex); j++){
			var currentInst = instance_find(objectIndexes[i].oIndex,j);
			storeInstance(cRoom.loadedEntities, currentInst, objectIndexes[i].variables);
		}
	}
}

function storeInstance(queue, instance, variables){
	var summonArray = [];
	for (var i = 0; i < array_length(variables); i++){
		summonArray[i] = [variables[i], variable_instance_get(instance, variables[i])]
	}
	summonArray[array_length(variables)] = ["oldInstance", true]
	var newEntry =  {objIndex:instance.object_index,
		summonArray: summonArray
	}
	ds_queue_enqueue(queue,newEntry);
}
function loadRoom(newRoom){
	var insts = newRoom.loadedEntities
	var queueLen = ds_queue_size(insts)
	for (var i = 0; i < queueLen; i++){
		var instance = ds_queue_dequeue(insts)
		summonObject(instance.objIndex, instance.summonArray);
	}
	print(newRoom);
	for (var i = 0; i < array_length(newRoom.roomInfo.instances); i++){
		var instance = newRoom.roomInfo.instances[i];
		summonObject(instance.objectIndex, instance.summonArray);
	}
	SignalSend("doors:", currentRoom)

}

function checkCleared(){
	//print("clearcheck: ",instance_number(obj_enemy),"&",instance_number(obj_enemySpawner))
	ds_grid_get(currentFloor.grid, currentRoom.coords[0], currentRoom.coords[1]).cleared = 
		instance_number(obj_enemy) == 0 && 
		instance_number(obj_enemySpawner) == 0 &&
		instance_number(obj_bossSpawner) == 0 &&
		instance_number(obj_boss) == 0
}

function changeFloor(currentDungeon, floorNo){
	print("lol")
	for (var i = 0; i < ds_list_size(currentDungeon.floors); i++){
		print(ds_list_find_value(currentDungeon.floors,i));
	}
	var currentFloorNo = floorNo
	var currentFloor = ds_list_find_value(currentDungeon.floors, currentFloorNo)
	return currentFloor;
}
function lol(changeDiff){
	if inRange(currentFloorNo+floorDiff, 0, currentDungeon.floorCount){
		reachFloor(currentFloorNo+floorDiff)
	}else{
		forceCrash("floorNo outside of available floors: " +string(currentFloorNo+floorDiff))
	}
}
SignalSend("getTransitionFunction")

function summonDungeonTrans(){
	summonObject(obj_dungeonTrans, [["x", room_width/2],["y",room_height/2]])
}
//SignalSubscribe(id, "roomEntered: newRoom", roomEnterLogic);
