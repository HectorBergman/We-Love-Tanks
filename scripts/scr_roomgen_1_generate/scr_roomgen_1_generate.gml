function generate(dfloor, goalCoords,startingRoom){
	var roomsQueue = ds_queue_create();
	//first step:
	//no need to generateDoors

	ds_queue_destroy(roomsQueue);
}

function queueRoom(roomsQueue,_room,parentDirection){
	//_room.doors = noDoors
	/*_room.doors[parentDirection] = doorValues.open;
	_room.doors = doors;*/
	
	// shouldnt be needed with openDoor
	
	//ds_map_add(queuedRoomsMap,coordString,{coords:coords,doors:doors}); maybe needed..?
	ds_queue_enqueue(roomsQueue,_room);
}
function dequeueRoomCoordinates(roomsQueue,coords){
	var val = ds_queue_dequeue(roomsQueue);
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
function iterateRoom(dfloor, roomCoords, doors = [-1,-1,-1,-1]){
	var _room = ds_grid_get(dfloor.grid,roomCoords[0],roomCoords[1]);
	var checkedDoors = [];
	if doors[0] == -1{ //if doors not preset by func, check if neighbours have door leading to room
		for (var i = 0; i < array_length(doors); i++){
			var XY = getXY(i)
			var neighbouringRoom = ds_grid_get(dfloor.grid, roomCoords[0]+XY[0],roomCoords[1]+XY[1])
			/*if roomExists(neighbouringRoom) && neighbouringRoom.doors[(i+2)mod 4]{
				doors[i] = doorValues.open;
			}*/
		}
		generateDoors(dfloor, _room);
	}
	var doorsAmt = 0;
	for (var i = 0; i < array_length(doors); i++){
		if doors[i]{
			openDoor(dfloor, _room, i);
			var XY = getXY(i)
			var neighbouringRoom = ds_grid_get(dfloor.grid, roomCoords[0]+XY[0],roomCoords[1]+XY[1])
			
			if !roomExists(neighbouringRoom){//inherit doors.. dont forget 2 do that
				var newRoom = createRoom(dfloor, [roomCoords[0]+XY[0],roomCoords[1]+XY[1]], i)
				//ds_queue_enqueue(
			}
			doorsAmt++;
		}
	}
	if doorsAmt == 1{
		cRoom.isEdgeRoom = true;
	}
	
	
}

function generateDoors(dfloor, _room){
	var doors = _room.coords
	var doorCount = 0;
	var predecidedDoors = [];
	var newDoors = [];
	//find out where room came from
	//do sumn if outside grid
	for (var i = 0; i < array_length(doors); i++){
		if doors[i]{
			predecidedDoors[doorCount] = i;
			doorCount++
			_room.doorWeights[i-1] = 0;
		}
	}
	var undecidedDoors = [0,1,2,3];
	var minusIndex = 0;
	for (var i = 0; i < array_length(undecidedDoors); i++){
		if array_contains(predecidedDoors,undecidedDoors[i-minusIndex]){
			array_delete(undecidedDoors,i-minusIndex,1);
			minusIndex++;
		}
	}
	
	//using doorWeight, decide how many doors a room shall have
	var weightSum = 0;
	for (var i = 0; i < array_length(_room.doorWeights); i++){
		weightSum += _room.doorWeights[i]
		_room.doorWeights[i] = weightSum;
	}
	var randomWeighted = random(1)*weightSum
	var chosenDoorCount = -1;
	for (var i = 0; i < array_length(_room.doorWeights); i++){
		if _room.doorWeights[i] >= randomWeighted{
			chosenDoorCount = i;
			break;
		}
	}
	
	var openDoors = array_length(predecidedDoors);
	while chosenDoorCount > openDoors{
		var randomIndex = irandom(array_length(undecidedDoors)-1);
		var doorNumber = undecidedDoors[randomIndex]
		openDoor(_room,doorNumber);
		newDoors[array_length(newDoors)] = doorNumber;
		array_delete(undecidedDoors, randomIndex,1);
		openDoors++;
	}
	
	return newDoors
}

function openDoor(_room,doorNumber){
	_room.doors[doorNumber] = doorValues.open;
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