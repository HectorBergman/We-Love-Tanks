function generateDungeon(){
	ds_grid_clear(dungeonGrid,noone)//, {_room : rm_errorRoom, doors : [0,0,0,0]});
	var uniqueIDGiver = 0;
	
	spiralGridScan(currentRoom[0],currentRoom[1],10,10,function(i,j) {
		createRoom(i,j,uniqueIDGiver);
		uniqueIDGiver++
	});
	spiralGridScan(currentRoom[0],currentRoom[1],10,10,function(i,j) {
		var visitedRooms = ds_list_create();
		if !roomLooper(i,j,visitedRooms){
			deleteRoom(_x,_y);
		}
		ds_list_destroy(visitedRooms);
	});
}

function roomLooper(originX,originY,visitedRooms,blockedDirection = -1){
	var itWorks = false;
	for (var i = 0; i < 4; i++){
		if i != blockedDirection{
			var result = checkAdjacentRooms_helper(originX,originY,i)
			if result[5] == 1 && ds_list_find_index(visitedRooms,result.uniqueID) == -1{
				ds_list_add(visitedRooms,result.uniqueID);
				var xY = directionToXY(i);
				if roomLooper(_x+xY[0],_y+xY[1],visitedRooms,directionToXY( (i+2) mod 4) ){
					itWorks = true;
					break;
				}
			}
		}
	}
	return itWorks
}

function deleteRoom(_x,_y){
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
			print("somethinwrongiholdmyheadmjgone")
		}else{
			adjacentRooms[0][i] = 0;
		}
	}
}


function createRoom(_x,_y, uniqueIDGiver){
	if _x == 5 && _y == 5{ //todo: make this not hardcoded, i.e. make it depend on where the middle is based on stage
		ds_grid_set(dungeonGrid, _x,_y, {_room : rm_startingRoom, doors : adjacentRooms[0], connectedToStart : [1,1,1,1], edge: false,roomID : uniqueIDgiver})
	}else{
		ds_grid_set(dungeonGrid, _x,_y, {_room : rm_roomTemplate, doors : adjacentRooms[0], connectedToStart : adjacentRooms[1][3], edge: false,roomID : uniqueIDgiver})
	}
}
function checkAdjacentRooms_helper(_x,_y,_direction){
	
	var adjacentRoom = [undefined,-9,-9,-9,-9]
	try{
		if _direction == 0{
			adjacentRoom = ds_grid_get(dungeonGrid, _x+1, _y)
			return [adjacentRoom, -1, 0, adjacentRoom.connectedToStart, adjacentRoom.doors[(_direction+2) mod 4]]
		}else if _direction == 1{
			adjacentRoom = ds_grid_get(dungeonGrid, _x, _y-1)
			return [adjacentRoom, 0, 1, adjacentRoom.connectedToStart, adjacentRoom.doors[(_direction+2) mod 4 ]]
		}else if _direction == 2{
			adjacentRoom = ds_grid_get(dungeonGrid, _x-1, _y)
			return [adjacentRoom, 1, 0, adjacentRoom.connectedToStart, adjacentRoom.doors[(_direction+2) mod 4 ]]
		}else if _direction == 3{
			adjacentRoom = ds_grid_get(dungeonGrid, _x, _y+1)
			return [adjacentRoom, 0, -1, adjacentRoom.connectedToStart, adjacentRoom.doors[(_direction+2) mod 4]]
		}
	}catch(e){
		print(e);
		return adjacentRoom
	}
}
//returns an array of 4 bools,
//index 0 = right, index 1 = up, index 2 = left, index 3 = down
//if true, means a room with an open door exists there
// 0 means room exists there but has closed door
//-1 means room is outside of dungeon area
//-2 means room has not been generated yet
function checkAdjacentRooms(_x,_y){
	if _x == 5 && _y == 5{ //todo: make this not hardcoded
		return [1,1,1,1]
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

