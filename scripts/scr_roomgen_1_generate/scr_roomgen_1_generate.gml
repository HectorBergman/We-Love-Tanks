function generateDFloor(dfloor){
	print("createDfloore")
	dfloor.roomsQueue = ds_queue_create();
	dfloor.queueGrid = ds_grid_create(dfloor.dimensions[0],dfloor.dimensions[1]);
	for (var i = 0; i < dfloor.dimensions[1]; i++){
		for (var j = 0; j < dfloor.dimensions[0]; j++){
			ds_grid_add(dfloor.queueGrid, i, j, false);
		}
	}
	var generateCount = iterateDFloor(dfloor);
	var entriesCount = fillEdgesArray(dfloor)
	//remove entry from dfloor.edgesArray if used
	if exitDungeon{
		return regenDfloor(dfloor.floorNo);
	}
	for (var i = 0; i < array_length(dfloor.specialRoomArray); i++){
		insertSpecialRoomInGrid(dfloor, dfloor.specialRoomArray[i])
		if exitDungeon{
			break;
		}
	}
	if exitDungeon{
		return regenDfloor(dfloor.floorNo);
	}
	visualizeFloor(dfloor)

	
	return dfloor;
}

function iterateDFloor(dfloor){
	var generateCount = 1;
	iterateRoom(dfloor,ds_grid_get(dfloor.grid,dfloor.startPoint[0],dfloor.startPoint[1]));
	while !ds_queue_empty(dfloor.roomsQueue){
		var newRoom = ds_queue_dequeue(dfloor.roomsQueue);
		iterateRoom(dfloor,newRoom)
		generateCount++;
		print("penis")
		print(dfloor)
		recalibrateDoorWeights(dfloor,dfloor.roomAmountRange[1],generateCount)
	}
	return generateCount
}
function fillEdgesArray(dfloor){
	var entriesCount = 0;
	for (var j = 0; j < dfloor.dimensions[1]; j++){
		for (var i = 0; i < dfloor.dimensions[0]; i++){
			var _room = ds_grid_get(dfloor.grid, i, j)
			if roomExists(_room) && roomHasOneDoor(_room) && array_length(_room.amalgamClaimedCoords) == 1{
				_room.isEdgeRoom = true;
				dfloor.edgesArray[entriesCount] = [i,j] 
				//^^_room.coords if you want this to be writeable thru dfloor.edgesArray for some reason
				entriesCount++;
			}
		}
	}
	return entriesCount
}
function roomHasOneDoor(_room){
	var doors = _room.doors;
	var doorCount = 0;
	for (var i = 0; i < array_length(doors); i++){
		if doors[i] == 1{
			doorCount++;
		}
		if doorCount > 1{
			return false;
		}
	}
	return doorCount == 1
}
function insertSpecialRoomInGrid(dfloor, sRoom){
	var newCoords = specialRoomGetCoords(dfloor, sRoom)
	if exitDungeon{
		exit;
	}
	var newRoom = createRoom(dfloor, newCoords, getPremadeRoomDir(dfloor, ds_grid_get(dfloor.grid,newCoords[0],newCoords[1])),sRoom)
	ds_grid_set(dfloor.grid, newCoords[0], newCoords[1], newRoom);
}

function getPremadeRoomDir(dfloor,sRoom){
	var doors = sRoom.doors
	var doorNo = -1;
	for (var i = 0; i < array_length(doors); i++){
		if doors[i] == 1{
			if doorNo == -1{
				doorNo = i;
			}else{
				forceCrash("Room has more than one door")
			}
		}
	}
	return doorNo
}

function specialRoomGetCoords(dfloor,sRoom){
	var arr = getAllAvailableCoordsFittingReq(dfloor, sRoom.positionRequirements)
	var potentialCoords = getAllAvailableRoomsFittingReq(dfloor,arr);
	if (array_length(potentialCoords) == 0){
		print("exitReason: array_length(potentialCoords) == 0");
		exitDungeon = true;
		exit;
	}
	var coord = setRandomCoordInArray(potentialCoords, dfloor);
	var arrIndex = findArrayIndexInArray(dfloor.edgesArray,coord)
	if arrIndex != -1{
		array_delete(dfloor.edgesArray,arrIndex,1);
	}else{
		forceCrash("coord not in edgesarray")
	}

	updateRoomsGridInfo(dfloor, sRoom, coord);
	return sRoom.gridInfo.placedCoords
	
}
function getAllAvailableRoomsFittingReq(dfloor,coordsArray){
	var validRooms = [];
	var index = 0;
	for (var i = 0; i < array_length(coordsArray); i++){
		if arrayContainsArray(dfloor.edgesArray, coordsArray[i]){
			validRooms[index] = coordsArray[i];
			index++;
		}
	}
	if array_length(validRooms) == 0{
		print("exitReason: array_length(validRooms) == 0");
		retryDFloorGen(dfloor)
	}
	return validRooms;
}

function retryDFloorGen(dfloor){
	exitDungeon = true;

}

function getStageNumber(dfloor,currentRoomAmount,goalAmount, possibleDoorWeights){
	var stageAmount = struct_names_count(possibleDoorWeights);
	var count = currentRoomAmount + ds_queue_size(dfloor.roomsQueue);
	for (var i = stageAmount-1; i > 0; i--){
		if (count > (i-0.5)*goalAmount/stageAmount){
			return i;
		}
	}
}
function recalibrateDoorWeights(dfloor, goalAmt, currentRoomAmount){
	var stageNumber = getStageNumber(dfloor,currentRoomAmount, goalAmt, dfloor.possibleDoorWeights)
	var doorWeight = variable_struct_get(dfloor.possibleDoorWeights, "stage" + string(stageNumber));
	dfloor.doorWeights = doorWeight;
}

function changeDoorState(dfloor, coords, dir, state){
	var _room = ds_grid_get(dfloor.grid, coords[0],coords[1]);
	_room.doors[dir] = state
	var XY = getXY(dir);
	var neighbour = ds_grid_get(dfloor.grid, coords[0]+XY[0], coords[1]+XY[1]);

	neighbour.doors[(dir+2)mod 4] = state
}

function openDoor(dfloor, coords, dir){
	changeDoorState(dfloor, coords, dir, doorValues.open)
}
function closeDoor(dfloor, coords,dir){
	changeDoorState(dfloor, coords, dir, doorValues.closed)
}

function iterateRoom(dfloor, _room, doors = [-1,-1,-1,-1]){
	var doneArray = []
	var amalgamAmt = array_length(_room.amalgamClaimedCoords);
	for (var i = 0; i < amalgamAmt; i++){
		doneArray[i] = false;
	}
	var ccPos = arrayInArrayPosition(_room.amalgamClaimedCoords,_room.coords)
	iterateRoom_helper(dfloor,_room, ccPos, doors)
	doneArray[ccPos] = true;
	for (var i = 0; i < amalgamAmt; i++){
		if !doneArray[i]{
			iterateRoom_helper(dfloor,_room, i, doors)
		}
	}
}

function iterateRoom_helper(dfloor,_room, index, doors){
	var newRoom = variable_clone(_room);
	var oldCoords = newRoom.coords
	newRoom.coords = [_room.amalgamClaimedCoords[index][0], _room.amalgamClaimedCoords[index][1]]
	newRoom.doors = ds_grid_get(dfloor.grid, newRoom.coords[0], newRoom.coords[1]).doors
	ds_grid_set(dfloor.grid, _room.amalgamClaimedCoords[index][0],_room.amalgamClaimedCoords[index][1], newRoom);
	if doors[0] == -1{
		generateDoors(dfloor, newRoom);
	}
}

function generateDoors(dfloor, _room){
	//step 1: discern door amounts
	var doors = _room.doors;
	print(" generateDoors: " + string(_room.coords));
	print(doors);
	var weights = [];
	array_copy(weights, 0, _room.doorWeights, 0, array_length(_room.doorWeights));

	var predecidedOpenDoors = 0;
	var predecidedDoors = [-1,-1,-1,-1]
	var borderDoors = 0;
	
	var totalOpenDoors = 0;
	//find doors that lead outside the grid (borderDoors)
	//and doors that are already open (predecidedOpenDoors)
	for (var i = 0; i < array_length(doors); i++){
		var XY = getXY(i);
		var nextCoords = [_room.coords[0]+XY[0],_room.coords[1]+XY[1]]
		if !coordsWithinGrid(nextCoords,dfloor.dimensions){
			if doors[i] == 1{
				closeDoor(dfloor,_room.coords,i);
			}
			borderDoors++;
			if array_length(weights)-borderDoors-1 != -1{
				weights[array_length(weights)-borderDoors-1] += weights[array_length(weights)-borderDoors]
			}
			weights[array_length(weights)-borderDoors] = 0;
			predecidedDoors[i] = 0;
		}else if doors[i] == 1{
			openDoor(dfloor, _room.coords, i);
			weights[predecidedOpenDoors] = 0;
			predecidedOpenDoors++;
			predecidedDoors[i] = 1;
			totalOpenDoors++;
		}
	}
	var validDoorNumbers = [];
	var vdIndex = 0;
	for (var i = 0; i < array_length(predecidedDoors); i++){
		if predecidedDoors[i] == -1{
			validDoorNumbers[vdIndex] = i;
			vdIndex++;
		}
	}
	var weightSum = 0;
	for (var i = 0; i < array_length(weights); i++){
		weightSum += weights[i];
		weights[i] = weightSum;
	}
	var doorNumberRandom = random(1)*weightSum;
	var doorAmtChosen = -1;
	
	if weightSum > 0{
		for (var i = 0; i < array_length(weights); i++){
			doorAmtChosen = i
			if weights[i] > doorNumberRandom{
				break;
			}
		}
		doorAmtChosen -= predecidedOpenDoors;
		while doorAmtChosen > 0{
			var randomDoorNo = irandom(array_length(validDoorNumbers)-1);
			var doorNoChosen = validDoorNumbers[randomDoorNo];
			openDoor(dfloor,_room.coords,doorNoChosen);
			totalOpenDoors++;
			var XY = getXY(doorNoChosen);
			var nextCoords = [_room.coords[0]+XY[0],_room.coords[1]+XY[1]]
			var nextRoom = ds_grid_get(dfloor.grid,nextCoords[0],nextCoords[1])
			if !roomExists(nextRoom) && !roomIsClaimed(nextRoom){
				var newRoom = createRoom(dfloor, nextCoords,doorNoChosen)
				ds_queue_enqueue(dfloor.roomsQueue,newRoom);
				for (var i = 0; i < array_length(newRoom.amalgamClaimedCoords); i++){
					var roomToClaim = ds_grid_get(dfloor.grid, newRoom.amalgamClaimedCoords[i][0], newRoom.amalgamClaimedCoords[i][1])
					roomToClaim.roomType = "claimed";
				}
			}
			array_delete(validDoorNumbers, randomDoorNo, 1);
			doorAmtChosen--;
		}
	}
	print("donezo");
	return doors;
}


function arrayContainsArray(array, valueArray){
	for (var i = 0; i < array_length(array); i++){
		if array_equals(valueArray,array[i]){
			return true;
		}
	}
	return false;
}

function arrayInArrayPosition(array, valueArray){
	for (var i = 0; i < array_length(array); i++){
		if array_equals(valueArray,array[i]){
			return i;
		}
	}
	return -1;
	return -1;
}


function roomIsClaimed(_room){
	return _room.roomType == "claimed"
}

