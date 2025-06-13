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
		newRoom = {_room : {roomName: "home", instances:[],difficulty: "0", roomShape: "normal"}, 
		roomShape:global.roomShapes[0], 
		roomShapeInfo: {roomNo: 0,leftOverEntities: ds_list_create(),roommates: [[i,j],[-777,-777],[-777,-777],[-777,-777]]}, 
		edge: false, roomID : uniqueIDGiver, coords : [i,j], 
		cleared: false,visited: true, originDir : getDir(originXY)}
	}else{
		newRoom = {_room : pickRandomRoomByType(global.roomList,"standard", "normal"), 
		roomShape:global.roomShapes[0], 
		roomShapeInfo: {roomNo: 0,leftOverEntities: ds_list_create(),roommates: [[i,j],[-777,-777],[-777,-777],[-777,-777]]}, 
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
			array_insert(roomsArray, i, [-777,-777]);
			continue;
		}
		var curRoom = ds_grid_get(dungeonGrid,roomsArray[i][0],roomsArray[i][1]);
		
		curRoom.roomShapeInfo = 
		{roomNo: i,leftOverEntities: curRoom.roomShapeInfo.leftOverEntities,
			roommates: roomsArray}
		curRoom.roomShape = roomShape;
		curRoom.edge = hasEdge;
		curRoom._room = _room
		ds_grid_set(dungeonGrid,roomsArray[i][0],roomsArray[i][1], curRoom);
		fakeI++
	}
}

function room_getAllDoors(_room){
	var roomiesArr = _room.roomShapeInfo.roommates;
	var doorsArr = [];
	for (var i = 0; i < 4; i++){
		print(roomiesArr);
		if roomiesArr[i][0] != -777{
			var cRoom = ds_grid_get(dungeonGrid, roomiesArr[i][0], roomiesArr[i][1])
			print("roomie: " + string(roomiesArr[i][0]) + " n " + string(roomiesArr[i][1]));
		
			print("hello");
			print(cRoom);
			doorsArr[i] = cRoom.doors;
		}else{
			doorsArr[i] = [0,0,0,0];
		}
	}
	print("getDoorsdone");
	return doorsArr;
}

function room_clear(_room){
	var roomies = _room.roomShapeInfo.roommates
	var len = array_length(roomies)
	if  len == 0{
		_room.cleared = true;
	}else{
		for (var i = 0; i < len; i++){
			if roomies[i] != noone{
				roomies[i].cleared = true;
			}
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
























