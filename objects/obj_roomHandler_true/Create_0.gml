pauseMode = [pM.pauseMenu];
global.newRoom = true;
enterInfo = {
	enteredRoomCoords: [-1,-1], 
	enteredRoomDoor: 0,
	enteredRoomNo: 0,
	enteredRoomDir: [-1,-1]
}
enteredDoor = -1
var startPoint = [1,1]
var spezRooms = [
	createSpecialRoom("item", posRequirement(coordsWithinRangeChebyshev,[startPoint, 0,3])),
	createSpecialRoom("boss", posRequirement(coordsWithinRangeChebyshev,[startPoint, 0,3]))
]
floorReqs = ds_list_create()
var oneReq = floorRequirements([3,3],startPoint,0.1,[[0,0,4,2,1], [0,0.5,4,1,1], [0,1,2,2,1], [0,1,4,1,0.5], [0,1.1,0.5,0,0]],[4,8],spezRooms)
SignalSubscribe(id,"roomEntered: general", function(){
	print("roomentered: ",currentRoom.doors);
	SignalSend("roomEntranceNo", (enteredDoor+2) mod 4);
	SignalSend("doors:", currentRoom.doors);
	SignalSend("clearedStatus", currentRoom.cleared);
	loadRoom(currentRoom)
})
ds_list_add(floorReqs, oneReq);
ds_list_add(floorReqs, oneReq);
currentDungeon = initiateDungeon(floorReqs);
changeFloor(0)

currentRoom = ds_grid_get(currentFloor.grid, currentFloor.startPoint[0],currentFloor.startPoint[1])
print(ds_grid_get(currentFloor.grid, 0,0))
SignalSubscribe(id,"transportRoom",function(arg){
	enterNewRoom(arg[0],arg[1],arg[2],arg[3]);
});

function enterNewRoom(xDirection, yDirection,roomNo,doorNo){
	storePreviousRoom();
	checkCleared()
	enteredDoor = doorNo;
	currentRoom.visited = true;
	//var extraDiff = getRoomDiff(enterInfo.enteredRoomNo,roomNo);
	//enterInfo.enteredRoomDoor = doorNo;
	var newCoords = [currentRoom.coords[0]+xDirection, currentRoom.coords[1]+yDirection]//+extraDiff[0],currentRoom[1]+yDirection+extraDiff[1]];
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
	//isNewRoom = true;
}

function gotoRoom(_room){
	
	//nextInstances = _room.instances;
	room_goto(asset_get_index("rm_roomTemplate_" + _room.roomShape[0]));
}

function storePreviousRoom(){
	var cRoom = ds_grid_get(currentFloor.grid, currentRoom.coords[0], currentRoom.coords[1])
	
	for (var i = 0; i < instance_number(obj_enemy); i++){
		
		var currentInst = instance_find(obj_enemy,i);
		var newEntry = {objIndex:currentInst.object_index,
			summonArray:
				[["x",currentInst.x],
				["y",currentInst.y],
				["hp",currentInst.hp],
				["enemyType",currentInst.enemyType]]
		}
		ds_queue_enqueue(cRoom.loadedEntities,newEntry);
		
	}
	for (var i = 0; i < instance_number(obj_item); i++){
		var currentInst = instance_find(obj_item,i);
		if currentInst.state != itemState.collected{
			var newEntry =  {objIndex:currentInst.object_index,
				summonArray:
					[["x",currentInst.x],
					["y",currentInst.y],
					["itemId", currentInst.itemId]]
			}
			ds_queue_enqueue(cRoom.loadedEntities,newEntry);
		}
	}
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
}

function checkCleared(){
	//print("clearcheck: ",instance_number(obj_enemy),"&",instance_number(obj_enemySpawner))
	ds_grid_get(currentFloor.grid, currentRoom.coords[0], currentRoom.coords[1]).cleared = 
		instance_number(obj_enemy) == 0 && 
		instance_number(obj_enemySpawner) == 0
}

function changeFloor(floorNo){
	currentFloorNo = floorNo
	currentFloor = ds_list_find_value(currentDungeon.floors, currentFloorNo)
}
function lol(changeDiff){
	if inRange(currentFloorNo+floorDiff, 0, currentDungeon.floorCount){
		reachFloor(currentFloorNo+floorDiff)
	}else{
		forceCrash("floorNo outside of available floors: " +string(currentFloorNo+floorDiff))
	}
}
SignalSend("getTransitionFunction")
//SignalSubscribe(id, "roomEntered: newRoom", roomEnterLogic);
