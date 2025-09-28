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

//SignalSubscribe(id, "roomEntered: newRoom", roomEnterLogic);
