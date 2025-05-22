function generateDungeon(){
	ds_grid_clear(dungeonGrid,noone)//, {_room : rm_errorRoom, doors : [0,0,0,0]});

	spiralGridScan(currentRoom[0],currentRoom[1],10,10,function(i,j) {
		createRoom(i,j);
		uniqueIDGiver++
	});
	print("areweconnected?")
	
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
		newRoom = {_room : rm_startingRoom, doors : [1,1,1,1], connectedToStart : true, edge: false,roomID : uniqueIDGiver, coords : [_x,_y]}
	}else{
		var adjacentDoors = checkAdjacentRooms(_x,_y)[0]
		for (var i = 0; i < 3; i++){
			if adjacentDoors[i] == -2{
				adjacentDoors[i] = random(1) < 0.01 //0.39
			}
		}
		print("room created on " + string(_x) + "," + string(_y));
		
		newRoom = {_room : asset_get_index(pickRandomRoomByType(global.roomList,"boringAf").roomName), doors : adjacentDoors, connectedToStart : false, edge: isEdge(adjacentDoors),roomID : uniqueIDGiver, coords : [_x,_y]}
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

