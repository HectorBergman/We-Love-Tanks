enum doorTypes{//idk if this will be relevant
	closed,
	opened,
	wideOpen
}

function generateDungeon(){
	print("Generate dungeon: Start.");
	var edges = ds_list_create() //store edges in case room not big enough
	ds_grid_clear(dungeonGrid,noone)
	dungeon_generate([5,5]);
	room_amalgamate([[7,5],[8,5],[8,6]],"bottomLeftAbsent");
	print(ds_grid_get(dungeonGrid,8,6)._room);
	//create an array with this and do room amalgamate, but first i have to make a tall room
	ds_list_destroy(edges);
	print("Generate dungeon: End.")
}
function dungeon_generate(startCoords){
	var queue = ds_queue_create();
	//start the breadth-first generation to generate rooms
	var newRoom = room_generate(startCoords[0],startCoords[1],[-2,-2]);
	ds_grid_set(dungeonGrid, startCoords[0],startCoords[1], newRoom);
	dungeon_addNeighbours(startCoords, newRoom, -1,queue, [1,1,1,1])
	while !ds_queue_empty(queue){
		print("pop!");
		dungeon_popEntry(queue);
	}
}
function dungeon_addNeighbours(roomCoords,_room, incomingDir, queue, forceDoors = [-1,-1,-1,-1]){
	//generate all doors and rooms. For each new room generated, iterate
	var doors = [0,0,0,0]
	if forceDoors[0] == -1{
		doors = 
		doors_generate( //generates an array of doors, rooms that lead to existing rooms will return 1
			[roomCoords[0],roomCoords[1]],
			incomingDir,
			0.33
		)
	}else{
		doors = forceDoors;
	}
	_room.doors = doors
	for (var i = 0; i < 4; i++){
		if i != incomingDir && doors[i]{
			print("Wegotin!");
			var xy = getXY(i);
			var adjacentRoom = ds_grid_get(dungeonGrid, roomCoords[0]+xy[0],roomCoords[1]+xy[1])
			if adjacentRoom == noone{ //Skip if room already exists
				
				var newRoom = room_generate(roomCoords[0]+xy[0],roomCoords[1]+xy[1],xy)
				ds_queue_enqueue(queue,newRoom)
			}
		}else{
			print("false");
		}
	}
}
function dungeon_popEntry(queue){
	var entry = ds_queue_dequeue(queue)
	ds_grid_set(dungeonGrid, entry.coords[0],entry.coords[1], entry);
	dungeon_addNeighbours(entry.coords,entry, entry.originDir, queue)
}
function room_generate(i,j,originXY){
	var newRoom = noone;
	if originXY[0] == -2 && originXY[1] == -2{ 
		newRoom = {_room : {roomName: "home", instances:[],difficulty: "0"}, 
		roomShape:global.roomShapes[0], 
		roomShapeInfo: {roomNo: 0,leftOverEntities: ds_list_create(),roommates: [],
		doors : [doorTypes.opened,doorTypes.opened,doorTypes.opened,doorTypes.opened]}, 
		edge: false, roomID : uniqueIDGiver, coords : [i,j], 
		cleared: false,visited: true, originDir : getDir(originXY)}
	}else{
		newRoom = {_room : pickRandomRoomByType(global.roomList,"standard", "normal"), 
		roomShape:global.roomShapes[0], 
		roomShapeInfo: {roomNo: 0,leftOverEntities: ds_list_create(),roommates: [],
		doors : [doorTypes.opened,doorTypes.opened,doorTypes.opened,doorTypes.opened]}, 
		edge: false/*somesortofisedgehere*/, roomID : uniqueIDGiver, coords : [i,j], 
		cleared: false,visited: false, originDir : getDir(originXY)}
	}
	return newRoom;
}

function doors_generate(roomCoords,incomingDirection,doorChance){
	doors = [0,0,0,0]

	if incomingDirection!= -1{	
		doors[incomingDirection] = 1;
	}
	for (var i = 0; i < 4; i++){
		if i != incomingDirection{
			
			var xy = getXY(i);
			var nextX = roomCoords[0] + xy[0]
			var nextY = roomCoords[1] + xy[1]
			
			if 
			 is_in_range(nextX, 0, dungeonSize) && 
			 is_in_range(nextY, 0, dungeonSize)
			{
				var directionNeighbour = ds_grid_get(dungeonGrid,nextX,nextY)
				if directionNeighbour != noone{
					
					doors[i] = directionNeighbour.doors[(i+2) mod 4]
				}else{
					
					if 
					 is_in_range(nextX, 0, dungeonSize) && 
					 is_in_range(nextY, 0, dungeonSize)
					{
						doors[i] = random(1) < doorChance
					}
				}
			}
		}
	}
	return doors;
}

function getXY(dir){
	if dir == 0{
		return [1,0];
	}else if dir == 1{
		return [0,-1]
	}else if dir == 2{
		return [-1,0]
	}else if dir == 3{
		return [0,1]
	}
	return [-2,-2]
}
function getDir(xy){
	if xy == [1,0]{
		return 0;
	}else if xy == [0,-1]{
		return 1
	}else if xy == [-1,0]{
		return 2
	}else if xy == [0,1]{
		return 3
	}
	print("dir not found!");
	return -1
}

function room_amalgamate(roomsArray,roomShape){
	if roomShape == global.roomShapes[0]{
		//maybe error here
		return;
	}else if roomShape == global.roomShapes[1] || roomShape == global.roomShapes[2]{
		var arrLen = array_length(roomsArray)
		if arrLen == 2{
			room_loopAmalgamate(roomsArray,roomShape,arrLen);
		}else{
			//error
		}
		
	}else if 
	(roomShape == global.roomShapes[3] || roomShape == global.roomShapes[4] || 
	 roomShape == global.roomShapes[5] || roomShape == global.roomShapes[6])
	{
		var arrLen = array_length(roomsArray)
		if arrLen == 3{
			room_loopAmalgamate(roomsArray,roomShape,arrLen);
		}else{
			//error
		}
	}else if roomShape ==global.roomShapes[7]{
		var arrLen = array_length(roomsArray)
		if arrLen == 4{
			room_loopAmalgamate(roomsArray,roomShape,arrLen);
		}else{
			//error
		}
	}else{
		//fo sho error here
		return;
	}
}
function room_loopAmalgamate(roomsArray,roomShape, arrLen){
	var roomShapeTable = getRoomShapeTable(roomShape);
	print("amalgam");
	var hasEdge = false;
	for (var i = 0; i < arrLen; i++){
		if ds_grid_get(dungeonGrid,roomsArray[i][0],roomsArray[i][1]).edge{
			hasEdge = true;
			break;
		}
	}
	var _room = pickRandomRoomByType(global.roomList,"standard",roomShape);
	print("penus");
	print(_room);
	var fakeI = 0;
	for (var i = 0; i < 4; i++){
		if roomShapeTable[i] == 0{
			continue;
		}
		var curRoom = ds_grid_get(dungeonGrid,roomsArray[fakeI][0],roomsArray[fakeI][1]);
		
		curRoom.roomShapeInfo = 
		{roomNo: i,leftOverEntities: curRoom.roomShapeInfo.leftOverEntities,
			roommates: roomsArray, doors : curRoom.roomShapeInfo.doors}
		curRoom.roomShape = roomShape;
		curRoom.edge = hasEdge;
		curRoom._room = _room
		ds_grid_set(dungeonGrid,roomsArray[fakeI][0],roomsArray[fakeI][1], curRoom);
		fakeI++
	}
}

function room_clear(_room){
	var roomies = _room.roomShapeInfo.roommates
	var len = array_length(roomies)
	if  len == 0{
		_room.cleared = true;
	}else{
		for (var i = 0; i < len; i++){
			roomies[i].cleared = true;
		}
	}
}
function room_visit(_room){
	var roomies = _room.roomShapeInfo.roommates
	var len = array_length(roomies)
	if  len == 0{
		_room.visited = true;
	}else{
		for (var i = 0; i < len; i++){
			roomies[i].visited = true;
		}
	}
}

function getDirIndex(i,j){
	if i == 1 && j == 0{
	}else if i == -1 && j == 0{
	}else if i == 0 && j == -1{
	}
}





























/*function generateDungeon(){
	ds_grid_clear(dungeonGrid,noone)//, {_room : rm_errorRoom, doors : [0,0,0,0]});

	spiralGridScan(currentRoom[0],currentRoom[1],10,10,function(i,j) {
		createRoom(i,j);
		uniqueIDGiver++
	});
	
	var visitedRooms = ds_list_create();
	allRooms = ds_map_create();
	roomLooperSpecil(5,5,visitedRooms,allRooms,0)
	ds_list_destroy(visitedRooms);
	
	for (var i = 0; i < 10; i++){
		for (var j = 0; j < 10; j++){
			if !(i == 5 && j == 5){
				try{

					var rID = ds_grid_get(dungeonGrid, i, j).roomID
					if (is_undefined(ds_map_find_value(allRooms, rID))){
						deleteRoom(i,j);
						
					}
				}
				catch(e){
					print("errorLOL!");
				}
			}else{
				ds_map_set(allRooms,0,0)
			}
		}
	}

	
	loopThroughDungeon(roomList);

	print(ds_list_size(roomList));
	print("here are all le rooms :))))")
	for (var i = 0; i < ds_list_size(roomList); i++){
		print(ds_list_find_value(roomList,i));
	}
	print(roomList);
	return roomList;
}

//This function is hell
function roomLooperSpecil(originX,originY,visitedRooms,allRooms,stepsFromMiddle,blockedDirection = -1){
	stepsFromMiddle++
	var currentRoom = ds_grid_get(dungeonGrid, originX, originY)
	for (var i = 0; i < 4; i++){
		if i != blockedDirection{
			var xY = directionToXY(i);
			if currentRoom.doors[i] != 1{
				continue;
			}
			if (!inRange(originX+xY[0],0,9) || !inRange(originY+xY[1],0,9)){
				print("Outside range");
				continue
			}
			
			
			
			var result = checkAdjacentRooms_helper(originX,originY,i)
			if (ds_list_find_index(visitedRooms,result[0]) != -1 && ds_map_find_value(allRooms, result[0].roomID) <= stepsFromMiddle) || is_undefined(result[0]){
				continue
			}

			ds_list_add(visitedRooms,result[0]);
			ds_map_set(allRooms, result[0].roomID, stepsFromMiddle)
			roomLooperSpecil(originX+xY[0],originY+xY[1],visitedRooms,allRooms,stepsFromMiddle,(i+2) mod 4)
			
		}
	}
	return false
}

function deleteRoom(_x,_y){
	ds_list_delete(roomList, ds_list_find_index(roomList,ds_grid_get(dungeonGrid,_x,_y)));
	ds_grid_set(dungeonGrid, _x,_y,undefined)
}
function directionToXY(_direction){
	if _direction == 0{
		return[1, 0]
	}else if _direction == 1{
		return[0, -1]
	}else if _direction == 2{
		return[-1, 0]
	}else if _direction == 3{
		return[0, 1]
	}
}
function checkingStuff(_x,_y){
	var adjacentRooms = checkAdjacentRooms(_x,_y); 
	var adjacentRoomsCounter = 0;
	for (var i = 0; i < 4; i++){
		if adjacentRooms[0][i] == 1{
			adjacentRoomsCounter++
			adjacentRooms[0][i] = 1;
		}else if adjacentRooms[i] == -2{
			adjacentRooms[0][i] = 0;
		}else if adjacentRooms[i] == -1{
			adjacentRooms[0][i] = 0;
		}else{
			adjacentRooms[0][i] = 0;
		}
	}
}


function createRoom(_x,_y){

	var newRoom = noone;
	if _x == 5 && _y == 5{ //todo: make this not hardcoded, i.e. make it depend on where the middle is based on stage
		newRoom = {_room : {roomName: "home", instances:[],difficulty: "0"}, doors : [1,1,1,1], connectedToStart : true, edge: false,roomID : uniqueIDGiver, coords : [_x,_y], cleared: true, leftOverEntities: ds_list_create(),visited:true}
	}else{
		var adjacentDoors = checkAdjacentRooms(_x,_y)[0]
		for (var i = 0; i < 3; i++){
			if adjacentDoors[i] == -2{
				adjacentDoors[i] = random(1) < 0.01 //0.39
			}
		}
		print("room created on " + string(_x) + "," + string(_y));
		
		newRoom = {_room : pickRandomRoomByType(global.roomList,"standard"), doors : adjacentDoors, connectedToStart : false, edge: isEdge(adjacentDoors),roomID : uniqueIDGiver, coords : [_x,_y], cleared: false, leftOverEntities: ds_list_create(),visited:false}
	}

	ds_list_add(roomList, newRoom);
	ds_grid_set(dungeonGrid, _x,_y, newRoom);
}
function checkAdjacentRooms_helper(_x,_y,_direction){
	
	var adjacentRoom = [undefined,-9,-9,-9,-9]
	var xy = directionToXY(_direction);
	if inRange(_x+xy[0],0,9) && inRange(_y+xy[1],0,9){
		adjacentRoom = ds_grid_get(dungeonGrid, _x+xy[0], _y+xy[1])
		if adjacentRoom != noone{
			return [adjacentRoom, -xy[0], -xy[1], adjacentRoom.connectedToStart, adjacentRoom.doors[(_direction+2) mod 4]]
		}
		else return [undefined,-9,-9,-9,-9]
	
	}else{
		var adjacentRoo = [undefined,-9,-9,-9,-9]
		return adjacentRoo
	}
}

function randomizeDoors(percentageLikelihood){
	var array= [0,0,0,0];
	for (var i = 0; i < 4; i++){
		if random(1) < percentageLikelihood{
			array[i] = 1;
		}
	}
	return array;
}
//returns an array of 4 bools,
//index 0 = right, index 1 = up, index 2 = left, index 3 = down
//if true, means a room with an open door exists there
// 0 means room exists there but has closed door
//-1 means room is outside of dungeon area
//-2 means room has not been generated yet
function checkAdjacentRooms(_x,_y){
	if _x == 5 && _y == 5{ //todo: make this not hardcoded
		return [[1,1,1,1],1]
	}else{
		var returnArray = [[0,0,0,0], 0]
		for (var i = 0; i < 4; i++){
			var result = checkAdjacentRooms_helper(_x,_y,i)
			if !(result[0] == undefined || result[0] == -4) {
				if result[0].doors[(i+2) mod 4] == 1{
					if result[0]._room != rm_errorRoom{
						returnArray[0][i] = 1;
					}
					else{
						returnArray[0][i] = -1;
					}
					//createRoom(_x+result[0],_y+result[1])
				}else{
					returnArray[0][i] = 0;
				}
			}else{ returnArray[0][i] = -2
			}
		}
		return returnArray
	}
}
*/
