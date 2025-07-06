	/// @function           
/// @param {type}  
/// @param {type} 
/// @returns {type}

enum doorTypes{//idk if this will be relevant
	closed,
	opened,
	wideOpen
}

function generateDungeon(){
	roomAmount = 0;
	minRoom = 15;
	maxRooms = 20;
	print("Generate dungeon: Start.");
	itemRoomEdges = ds_list_create() //store edges in case room not big enough
	ds_grid_clear(dungeonGrid,noone)
	dungeon_generate([5,5]);

	ds_list_copy(itemRoomEdges, edgeList)
	
	while roomAmount < minRoom{
		addMoreRooms(edgeList,minRoom);
	}
	print(random_amalgamate());
	print(random_amalgamate());print(random_amalgamate());
	//currently crowns non-edge;
	crownItemRoom(itemRoomEdges);
	crownBossRoom(itemRoomEdges);
	print(roomAmount);
	print("Generate dungeon: End.")
}


/// @function			addMoreRooms(edgeList,minRoom)   
/// @description Extends the dungeon with more rooms if room count is equal to 
///minRoom, adding additional rooms to the edges in edgeList.
/// @param {list}		edgeList , A list of all edge rooms (dead-ends) available in the dungeon
/// @param {integer}	minRoom	 , The minimum amount of rooms required for the dungeon
/// @returns {room}		The room added
function addMoreRooms(edgeList,minRoom){
	print("addingRooms");
	if roomAmount < minRoom{
		var len = ds_list_size(edgeList);
		print(len);
		if len > 1{
			print("wein");
			var randomIndex = irandom(len-1);
			var roomCandidate = ds_list_find_value(edgeList,randomIndex);
			print(roomCandidate);
			var emptyNeighboursArr = room_getEmptyNeighbours(roomCandidate.coords);
			len = array_length(emptyNeighboursArr)
			if len > 0{
				var randomIndexCR = irandom(len-1);
				var chosenRoomCoords = emptyNeighboursArr[randomIndexCR]

				print("generating... at coords: " + string(chosenRoomCoords));
				print([roomCandidate.coords[0]-chosenRoomCoords[0],roomCandidate.coords[1]-chosenRoomCoords[1]]);
				return room_extend(roomCandidate.coords, chosenRoomCoords)
				
			}else{
				ds_list_delete(edgeList,randomIndex);
				return addMoreRooms(edgeList,minRoom);
			}
			
		}else{
			var lol = noone;
			lol.fail = 1;
		}
	}else{
		print("unnecessary");
		return -1
	}
}

function reEdge(edgeList, oldRoom, newRoom){
	oldRoom.edge = false;
	newRoom.edge = true;
	ds_list_delete(edgeList,ds_list_find_index(edgeList,oldRoom));
	ds_list_add(edgeList,newRoom);
}

function deEdge(edgeList, _room){
	_room.edge = false;
	ds_list_delete(edgeList,ds_list_find_index(edgeList,_room));
}

/// @function			room_extend(originRoomCoords, newRoomCoords) 
/// @description 
/// Adds room at given coordinates and connects it to the room at the origin coordinates
/// Assumes rooms are orthogonally adjacent, overwrites room at new room coordinates
/// @param {array}		originRoomCoords , the coords of the room to be extended onto
/// @param {array}		newRoomCoords , the coords where the new room will be
/// @returns {room}		room created

function room_extend(originRoomCoords, newRoomCoords){
	var XY = [originRoomCoords[0]-newRoomCoords[0],originRoomCoords[1]-newRoomCoords[1]]
	var newRoom = room_generate(newRoomCoords[0],newRoomCoords[1],XY)
	var oldRoom = ds_grid_get(dungeonGrid,originRoomCoords[0],originRoomCoords[1]);
	var dir = getDir(XY);
	var revDir = getDirReverse(XY);
	oldRoom.doors[revDir] = 1;
	reEdge(edgeList, oldRoom, newRoom)
	newRoom.doors[dir] = 1;
	ds_grid_set(dungeonGrid, newRoomCoords[0],newRoomCoords[1],newRoom);
	return newRoom;
	
}


/// @function			room_getEmptyNeighbours(roomCoords)
/// @description Given coordinates to a room, returns all orthogonally adjacent room positions that do not hold a room
/// Note: No check for if room is outside grid, but should work anyways
/// @param {array}		roomCoords , the coords of the room to check
/// @returns {array<array<integer>>}	an array of coords (array of 2 integers) that are the positions of the empty room spaces
function room_getEmptyNeighbours(roomCoords){
	var resultArr = [];
	for (var i = 0; i < 4; i++){
		var xy = getXY(i);
		var newCoords = [roomCoords[0]+xy[0], roomCoords[1]+xy[1]]
		var newRoom = ds_grid_get(dungeonGrid,newCoords[0],newCoords[1])
		if newRoom == noone{
			resultArr[array_length(resultArr)] = [newCoords[0],newCoords[1]]
		}
	}
	return resultArr
}

/// @function			dungeon_generate(startCoords)
/// @description Runs dungeon_popEntry until queue is empty, resulting in a breadth-first dungeon generation
/// @param {array}		startCoords , the coords from which the dungeon generation starts

function dungeon_generate(startCoords){
	var queue = ds_queue_create();
	//start the breadth-first generation to generate rooms
	var newRoom = room_generate(startCoords[0],startCoords[1],[-2,-2]);
	ds_grid_set(dungeonGrid, startCoords[0],startCoords[1], newRoom);
	dungeon_addNeighbours(startCoords, newRoom, -1,queue, [1,1,1,1])
	
	while !ds_queue_empty(queue){
		if roomAmount >= maxRooms{
			var _room = ds_queue_dequeue(queue)
			_room.doors[_room.reverseDir] = 1;
		}else{
			print("pop!");
			dungeon_popEntry(queue);
		}
	}
}


/// @function			dungeon_addNeighbours(roomCoords,_room, incomingDir, queue, forceDoors = [-1,-1,-1,-1])

/// Given the coordinates to a room, assigns doors to that room using doors_generate, and creates rooms 
/// based on new doors (not including already existing doors). New rooms are added to the queue to be popped
/// by dungeon_generate and dungeon_popEntry
/// Note: assumes room already exists
/// @param {array}		roomCoords , the coords of the room to add neighbours to
/// @param {room}		_room , the room itself (redundant...?)
/// @param {array}		incomingDir , the direction from which the room was generated in
/// @param {queue}		queue , the queue to add new rooms onto
/// @param {array}		forceDoors , If you need to force the doors to be some certain values, leave empty for no forced doors
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
	print("oneRun");
	print(incomingDir);
	var edgeDoors = [0,0,0,0]
	if sign(incomingDir) != -1{
		edgeDoors[incomingDir] = 1;
	}
	if !(array_equals(_room.doors, edgeDoors)){
		deEdge(edgeList, _room);
	}
	for (var i = 0; i < 4; i++){
		if i != incomingDir && doors[i]{
			print("Wegotin!");
			var xy = getXY(i);
			print(xy);
			var adjacentRoom = ds_grid_get(dungeonGrid, roomCoords[0]+xy[0],roomCoords[1]+xy[1])
			print(adjacentRoom);
			if adjacentRoom == noone{ //Skip if room already exists
				print("THESEARETHEROOMCOORDS:");
				print(roomCoords);
				print(_room);
				print("addingnewCoords: " + string(roomCoords[0]) + " + " + string(xy[0]) + " & " + string(roomCoords[1]) + " + " + string(xy[1]));
				print("AKA: " + string(roomCoords[0] + xy[0]) + " & " + string(roomCoords[1] +xy[1]));
				var newRoom = room_generate(roomCoords[0]+xy[0],roomCoords[1]+xy[1],xy)
				reEdge(edgeList, _room, newRoom)
				ds_grid_set(dungeonGrid,roomCoords[0]+xy[0],roomCoords[1]+xy[1],newRoom);
				ds_list_add(roomCoordsList, [roomCoords[0]+xy[0],roomCoords[1]+xy[1]])
				ds_queue_enqueue(queue,newRoom)
			}
		}else{
			print("false");
			print(roomCoords);
			print(doors);
		}
	}
}



/// @function			dungeon_popEntry(queue)
/// @description Given a queue, pops the latest entry, adds it to the grid, and runs dungeon_addNeighbours on it
/// Note: assumes queue is not empty
/// @param {queue}		queue , the queue to pop

function dungeon_popEntry(queue){
	var entry = ds_queue_dequeue(queue)
	ds_grid_set(dungeonGrid, entry.coords[0],entry.coords[1], entry);
	dungeon_addNeighbours(entry.coords,entry,entry.reverseDir, queue)
}


/// @function			room_generate(i,j,originXY)
/// @description Given coords and an integer vector normal, generates a basic room at those coordinates
/// @param {integer}	i	the x-coordinate of the new room
/// @param {integer}	j	the y-coordinate of the new room
/// @param {array}		originXY	the direction from which the room was extended on to
/// @returns {room}		the room generated
function room_generate(i,j,originXY){
	var newRoom = noone;
	roomAmount++
	if originXY[0] == -2 && originXY[1] == -2{ 
		newRoom = {_room : {roomName: "home", instances:[],difficulty: "0", roomShape: "normal"}, 
		roomShape:global.roomShapes[0], roomType : "standard",
		roomShapeInfo: {roomNo: 0,leftOverEntities: ds_list_create(),roommates: [[i,j],[-229,-229],[-229,-229],[-229,-229]]}, 
		edge: false, roomID : uniqueIDGiver, coords : [i,j], doors : [1,1,1,1], bossBeaten : false,
		cleared: false,visited: true, originDir : getDir(originXY), reverseDir: getDirReverse(originXY), amalgamated: false}
	}else{
		newRoom = {_room : pickRandomRoomByType(global.roomList,"standard", "normal"), 
		roomShape:global.roomShapes[0], roomType : "standard",
		roomShapeInfo: {roomNo: 0,leftOverEntities: ds_list_create(),roommates: [[i,j],[-229,-229],[-229,-229],[-229,-229]]}, 
		edge: false/*somesortofisedgehere*/, roomID : uniqueIDGiver, coords : [i,j], doors : [0,0,0,0], bossBeaten : false,
		cleared: false,visited: false, originDir : getDir(originXY), reverseDir: getDirReverse(originXY), amalgamated: false}
	}
	return newRoom;
}


/// @function			doors_generate(roomCoords,incomingDirection,doorChance)
/// @description Given coords to a room, the direction from which the room was spawned, and door odds, generates doors to that room.
/// @param {array}		roomCoords , the coords to the room
/// @param {integer}	incomingDirection , the direction from which the room was generated
/// @param {real}		doorChance , chance of spawning a door at any direction, between 0 and 1
/// @returns {array<integer>}	array of size 4 containing all doors (1 being a door there, 0 being no door)
function doors_generate(roomCoords,incomingDirection,doorChance){
	doors = [0,0,0,0]
	var noOtherDoors = true;
	if incomingDirection != -1{	
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
						var addDoor = random(1) < doorChance
						doors[i] = addDoor
						if addDoor{
							noOtherDoors = false;
						}
					}
				}
			}
		}
		
	}
	var theRoom = ds_grid_get(dungeonGrid, roomCoords[0], roomCoords[1])
	theRoom._room.isEdge = noOtherDoors;
	if noOtherDoors{
		print("noOtherDoors")
		ds_list_add(edgeList, theRoom);
	}
	return doors;
}



/// @function			getXY(dir)
/// @description Given a number from 0 to 3, returns an integer vector normal
/// Numbers outside 0 to 3 returns a vector of -2 , -2
/// @param {integer}	dir , number from 0 to 3, 0 being 0 degrees, with the other numbers increasing by 90 degrees each
/// @returns {array<integer>}	array of size 2 containing the integer vector normal
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


/// @function			getDir(xy)
/// @description Given an integer vector normal, returns a number from 0 to 3, 0 being 0 degrees, with the other numbers increasing by 90 degrees each
/// Arrays that are not 2-dimensional integer vector normals returns -1
/// @param {array}		xy , integer vector normal
/// @returns {integer}	array of size 2 containing the integer vector normal
function getDir(xy){
	print("dir:");
	print(xy);
	if array_equals(xy,[ 1,0 ]){
		return 0;
	}else if array_equals(xy,[ 0,-1 ]){
		return 1
	}else if array_equals(xy,[ -1,0 ]){
		return 2
	}else if array_equals(xy,[ 0,1 ]){
		return 3
	}
	print("dir not found!");
	return -1
}


/// @function			getDir(xy)
/// @description Given an integer vector normal, returns the result of getDir, but rotated 180 degrees.
/// Arrays that are not 2-dimensional integer vector normals returns -1
/// @param {array}		xy , integer vector normal
/// @returns {integer}	array of size 2 containing the integer vector normal rotated 180 degrees
function getDirReverse(xy){
	print("dir:");
	print(xy);
	if array_equals(xy,[ 1,0 ]){
		return 2;
	}else if array_equals(xy,[ 0,-1 ]){
		return 3
	}else if array_equals(xy,[ -1,0 ]){
		return 0
	}else if array_equals(xy,[ 0,1 ]){
		return 1
	}
	print("dir not found!");
	return -1
}


/// @function list_delete_by_array(list, search_array)
/// @description Deletes list entries that match either value in the search array
/// @param {list} list_id The list to modify
/// @param {array} search_array Array containing 2 values to search for
/// @returns {real} Returns the number of entries deleted

function list_delete_by_array(list_id, search_array) {
    // Check if the search array has exactly 2 elements
    if (!is_array(search_array) || array_length(search_array) != 2) {
        show_debug_message("list_delete_by_array: search_array must be an array with exactly 2 elements");
        return 0;
    }
    
    var val1 = search_array[0];
    var val2 = search_array[1];
    var deleted_count = 0;
    
    // Work backwards through the list to avoid index issues when deleting
    for (var i = ds_list_size(list_id) - 1; i >= 0; i--) {
        var current_value = list_id[| i];
        
        if (current_value == val1 || current_value == val2) {
            ds_list_delete(list_id, i);
            deleted_count++;
        }
    }
    
    return deleted_count;
}

/// @function  room_getAllDoors(_room)
/// @description retrieves all doors belonging to that room and it's roommates
/// @param {room} _room , room to retrieve from
/// @returns {array<integer>} The doors

function room_getAllDoors(_room){
	var roomiesArr = _room.roomShapeInfo.roommates;
	var doorsArr = [];
	for (var i = 0; i < 4; i++){
		print(roomiesArr);
		if roomiesArr[i][0] != -229{
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

/// @function  room_clear(_room)
/// @description sets the room's cleared status to true, also does this to the room's roommates
/// Note: cleared means the room has been visited and rid of all it's enemies
/// @param {room} _room , the room to clear
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
/// @function  room_visit(_room)
/// @description sets the room's visited status to true, also does this to the room's roommates
/// @param {room} _room , the room to visit
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

























