function generateDFloor(dfloor){
	dfloor.roomsQueue = ds_queue_create();
	dfloor.queueGrid = ds_grid_create(dfloor.dimensions[0],dfloor.dimensions[1]);
	for (var i = 0; i < dfloor.dimensions[1]; i++){
		for (var j = 0; j < dfloor.dimensions[0]; j++){
			ds_grid_add(dfloor.queueGrid, i, j, false);
		}
	}
	//first step:
	//no need to generateDoors
	var generateCount = 1;
	iterateRoom(dfloor,ds_grid_get(dfloor.grid,dfloor.startPoint[0],dfloor.startPoint[1]),dfloor.roomsQueue);
	while !ds_queue_empty(dfloor.roomsQueue){
		var newRoom = dequeueRoomCoordinates(dfloor.roomsQueue)
		iterateRoom(dfloor,newRoom, dfloor.roomsQueue, dfloor.goalCoords)
		generateCount++;
		recalibrateDoorWeights(dfloor,dfloor.roomsQueue,40,generateCount)
	}
	var edgeList_coord = [];
	var listPrint = "edgeList: "
	for (var i = 0; i < ds_list_size(dfloor.edgeList); i++){
		var entry = ds_list_find_value(dfloor.edgeList,i);
		listPrint += string(entry.coords) + ", "
		edgeList_coord[i] = entry.coords;
		if exitDungeon{
			break;
		}
	}
	if exitDungeon{
		return regenDfloor(dfloor.floorNo);
	}
	for (var i = 0; i < array_length(dfloor.specialRoomArray); i++){
		plopdownSpecialRoom(dfloor, edgeList_coord, dfloor.specialRoomArray[i])
		if exitDungeon{
			break;
		}
	}
	if exitDungeon{
		return regenDfloor(dfloor.floorNo);
	}
	//print(listPrint);
	visualizeFloor(dfloor);
	return dfloor;
}


function plopdownSpecialRoom(dfloor, edgeList_coord, sRoom){
	var newCoords = specialRoomGetCoords_gen(dfloor, edgeList_coord, sRoom)
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
					//forceCrash("more than one door present");

			}
		}
	}
}

function specialRoomGetCoords_gen(dfloor, edgelistCoords,sRoom){
	var arr = getAllAvailableCoordsFittingReq(dfloor, sRoom.positionRequirements)
	var potentialCoords = getAllAvailableRoomsFittingReq(dfloor,arr,edgelistCoords);
	if (array_length(potentialCoords) == 0){
		retryDFloorGen(dfloor)
		exit;
	}
	var coord = setRandomCoordInArray(potentialCoords, dfloor);

	//addRoomToGrid(dfloor, sRoom,coord)
	updateRoomsGridInfo(dfloor, sRoom, coord);
	return sRoom.gridInfo.placedCoords
	
}
function getAllAvailableRoomsFittingReq(dfloor,coordsArray, edgeListCoords){
	var validRooms = [];
	var index = 0;
	for (var i = 0; i < array_length(coordsArray); i++){
		if arrayContainsArray(edgeListCoords, coordsArray[i]){
			validRooms[index] = coordsArray[i];
			index++;
		}
	}
	if array_length(validRooms) == 0{
		retryDFloorGen(dfloor)
	}
	return validRooms;
}

function retryDFloorGen(dfloor){
	exitDungeon = true;

}

function getStageNumber(dfloor,currentRoomAmount,roomsQueue,goalAmount, possibleDoorWeights){
	var stageAmount = struct_names_count(possibleDoorWeights);
	var count = currentRoomAmount + ds_queue_size(roomsQueue);
	for (var i = stageAmount-1; i > 0; i--){
		if (count > (i-0.5)*goalAmount/stageAmount){
			return i;
		}
	}
}
function recalibrateDoorWeights(dfloor,roomsQueue, goalAmt, currentRoomAmount){
	var stageNumber = getStageNumber(dfloor,currentRoomAmount,roomsQueue, goalAmt, dfloor.possibleDoorWeights)
	var doorWeight = variable_struct_get(dfloor.possibleDoorWeights, "stage" + string(stageNumber));
	dfloor.doorWeights = doorWeight;
}
function calculateExpectedRoomCount(dfloor,roomsQueue){
	var avgDoors = averageRoomOffspring(dfloor);
	var qLen = ds_queue_size(roomsQueue);
	return qLen*avgDoors;
}

function averageRoomOffspring(dfloor){
	var weight = dfloor.doorWeights
	var weightSum = 0;
	var totalDoors = 0;
	for (var i = 1; i < array_length(weight); i++){
		weightSum += weight[i];
		totalDoors += weight[i]*(i-1);
	}
	return totalDoors/weightSum
}

function queueRoom(roomsQueue,_room,parentDirection){
	//_room.doors = noDoors
	/*_room.doors[parentDirection] = doorValues.open;
	_room.doors = doors;*/
	
	// shouldnt be needed with openDoor
	

	//ds_grid_set(queueGrid, _room.coords[0], _room.coords[1], true);
	ds_queue_enqueue(roomsQueue,_room);
}
function dequeueRoomCoordinates(roomsQueue){
	var val = ds_queue_dequeue(roomsQueue);
	//ds_grid_set(queueGrid, val.coords[0],val.coords[1], false);
	return val;
}
function changeDoorState(dfloor, _room, dir, state){
	_room.doors[dir] = state
	var XY = getXY(dir);
	var neighbour = ds_grid_get(dfloor.grid, _room.coords[0]+XY[0], _room.coords[1]+XY[1]);
	neighbour.doors[(dir+2)mod 4] = state


}
function openDoor(dfloor, _room, dir){
	changeDoorState(dfloor, _room, dir, doorValues.open)
}
function closeDoor(dfloor,_room,dir){
	changeDoorState(dfloor, _room, dir, doorValues.closed)
}
function iterateRoom(dfloor, _room, roomsQueue, goalCoords, doors = [-1,-1,-1,-1]){
	var roomCoords = _room.coords;

	var checkedDoors = [];
	if doors[0] == -1{ //if doors not preset by func, check if neighbours have door leading to room
		generateDoors(dfloor, _room, roomsQueue, goalCoords);
	}
	var doorsAmt = 0;
	for (var i = 0; i < array_length(doors); i++){
		if doors[i]{
			var XY = getXY(i)
			if (coordsWithinGrid([roomCoords[0]+XY[0],roomCoords[1]+XY[1]],dfloor.dimensions)){
				openDoor(dfloor, _room, i);
			
				var neighbouringRoom = ds_grid_get(dfloor.grid, roomCoords[0]+XY[0],roomCoords[1]+XY[1])
				
				doorsAmt++;
			}
		}
	}
	if doorsAmt == 1{
		_room.isEdgeRoom = true;
	}
	ds_grid_set(dfloor.grid, roomCoords[0],roomCoords[1], _room);
	
}

function findIllegitimateDoors(dfloor,_room){
	var coords = _room.coords;
	var bannedDoors = [];
	var index = 0;
	for (var i = 0; i < 4; i++){
		var XY = getXY(i);

		if !coordsWithinGrid([coords[0]+XY[0],coords[1]+XY[1]],dfloor.dimensions){
			bannedDoors[index] = i
			index++
		}
	}
	return bannedDoors;
}

function doorIsIllegitimate(dfloor,_room,doorDir){
	var XY = getXY(doorDir);
	if !coordsWithinGrid([_room.coords[0]+XY[0],_room.coords[1]+XY[1]],dfloor.dimensions){
			return true;
	}
	return false;
}
function generateDoors(dfloor, _room, roomsQueue, goalCoords){
	//step 1: discern door amounts
	var doors = _room.doors;
	var weights = [];
	print("hey");
	print(_room);
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
				closeDoor(dfloor,_room,i);
			}
			borderDoors++;
			if array_length(weights)-borderDoors-1 != -1{
				weights[array_length(weights)-borderDoors-1] += weights[array_length(weights)-borderDoors]
			}
			weights[array_length(weights)-borderDoors] = 0;
			predecidedDoors[i] = 0;
		}else if (arrayContainsArray(goalCoords, nextCoords) || doors[i] == 1){
			openDoor(dfloor, _room, i);
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
			openDoor(dfloor,_room,doorNoChosen);
			totalOpenDoors++;
			var XY = getXY(doorNoChosen);
			var nextCoords = [_room.coords[0]+XY[0],_room.coords[1]+XY[1]]
			
			if !roomExists(ds_grid_get(dfloor.grid,nextCoords[0],nextCoords[1])){
				var newRoom = createRoom(dfloor, nextCoords,doorNoChosen)
				queueRoom(roomsQueue, newRoom,(doorNoChosen+2) mod 2);
			}
			array_delete(validDoorNumbers, randomDoorNo, 1);
			doorAmtChosen--;
		}
	}
	if totalOpenDoors == 1{
		_room.isEdgeRoom = true;
		ds_list_add(dfloor.edgeList, _room);
	}
	return doors;
}

function getDirectionBias(dfloor, _room, validDoors){
	var goals = dfloor.goalCoords
	var coords = _room.coords;
	//jesus fuck thi shit
}

function findClosestCoordinate(coord,array){
	var closestCoord = [-1,-1]
	var closestDistance = 999999;
	for (var i = 0; i < array_length(array); i++){
		var coordinate = array[i];
		var distance = manhattanDistance(coord,coordinate);
		if closestDistance > distance{
			closestDistance = distance;
			closestCoord = coordinate;
		}
	}
	if closestCoord[0] == -1{
		print(closestCoord);
		print(closestDistance)
		print(array);
		forceCrash("findClosestCoordinate: array empty or otherwise closest coord not found!");
	}
	return closestCoord;
}
function arrayContainsArray(array, valueArray){
	for (var i = 0; i < array_length(array); i++){
		if array_equals(valueArray,array[i]){
			return true;
		}
	}
	return false;
}

function roomHasSpecialInfo(_room){
	return !_room.specialInfo == noone;
}


function getNeighboursExist(dfloor, coords){
	var neighbours = [];
	for (var i = 0; i < 4; i++){
		var dir = i;
		var XY = getXY(i);
		if coordsWithinGrid([coords[0]+XY[0],coords[1]+XY[1]], dfloor.dimensions) && 
		   roomExists(ds_grid_get(dfloor.grid, coords[0]+XY[0],coords[1]+XY[1])){
			neighbours[i] = true //do stuff here with doors and crap
		}else{
			neighbours[i] = false
		}
	}
}

/*doorOdds : [2,7,4,1], //index = amt doors (not counting door room came from
roomAmountRange : [30,40],

