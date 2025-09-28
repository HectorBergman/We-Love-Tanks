pauseMode = [pM.pauseMenu];
global.newRoom = true;
enterInfo = {
	enteredRoomCoords: [-1,-1], 
	enteredRoomDoor: 0,
	enteredRoomNo: 0,
	enteredRoomDir: [-1,-1]
}
var startPoint = [1,1]
var spezRooms = [
	createSpecialRoom("item", posRequirement(coordsWithinRangeChebyshev,[startPoint, 0,3])),
	createSpecialRoom("boss", posRequirement(coordsWithinRangeChebyshev,[startPoint, 0,3]))
]
floorReqs = ds_list_create()
var oneReq = floorRequirements([3,3],startPoint,0.1,[[0,0,4,2,1], [0,0.5,4,1,1], [0,1,2,2,1], [0,1,4,1,0.5], [0,1.1,0.5,0,0]],[4,8],spezRooms)

ds_list_add(floorReqs, oneReq);ds_list_add(floorReqs, oneReq);
currentDungeon = initiateDungeon(floorReqs);
changeFloor(0)
currentRoom = ds_grid_get(currentFloor.grid, currentFloor.startPoint[0],currentFloor.startPoint[1])
print(currentRoom)
SignalSubscribe(id,"transportRoom",function(arg){
	enterNewRoom(arg[0],arg[1],arg[2],arg[3]);
});

function enterNewRoom(xDirection, yDirection,roomNo,doorNo){
	//storePreviousRoom();
	checkCleared()
	//var extraDiff = getRoomDiff(enterInfo.enteredRoomNo,roomNo);
	//enterInfo.enteredRoomDoor = doorNo;
	currentRoom.coords = [currentRoom.coords[0]+xDirection, currentRoom.coords[1]+yDirection]//+extraDiff[0],currentRoom[1]+yDirection+extraDiff[1]];
	var newRoom = ds_grid_get(currentFloor.grid, currentRoom.coords[0], currentRoom.coords[1])
	if inRange(currentRoom.coords[0], 0, currentFloor.dimensions[0]) && inRange(currentRoom.coords[1], 0, currentFloor.dimensions[1]) && !is_undefined(newRoom) && newRoom != noone{
		//obj_currentRoomHandler.roomDoors = room_getAllDoors(newRoom);
		gotoRoom(newRoom);
		//enterInfo.enteredRoomNo = newRoom.roomShapeInfo.roomNo
	}else{
		currentRoom = undefinedCoords;
		forceCrash("roomOutsideBoundaries");
		//todo: add error room
	}
	isNewRoom = true;
}

function gotoRoom(_room){
	
	//nextInstances = _room.instances;
	room_goto(asset_get_index("rm_roomTemplate_" + _room.roomShape[0]));
}

function storePreviousRoom(){
	var cRoom = ds_grid_get(currentFloor.grid, currentRoom.coords[0], currentRoom.coords[1])
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

function checkCleared(){
	if instance_number(obj_enemy) == 0 && instance_number(obj_enemySpawner) == 0{
		ds_grid_get(currentFloor.grid, currentRoom.coords[0], currentRoom.coords[1]).cleared = true;
	}else{
		ds_grid_get(currentFloor.grid, currentRoom.coords[0], currentRoom.coords[1]).cleared = false;
	}
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
