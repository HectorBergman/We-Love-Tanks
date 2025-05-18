function generateDungeon(){
	ds_grid_clear(dungeonGrid,noone)//, {_room : rm_errorRoom, doors : [0,0,0,0]});
	
	spiralGridScan(currentRoom[0],currentRoom[1],10,10,function(i,j) {
		createRoom(i,j);
		uniqueIDGiver++
	});
	print("areweconnected?")
	spiralGridScan(currentRoom[0],currentRoom[1],10,10,function(i,j) {
		if (!(i == 5 && j == 5)){
			var visitedRooms = ds_list_create();
			var origin = [i,j]
			if !roomLooper(i,j,visitedRooms, -1, origin){
				//print("hello");
				deleteRoom(i,j);
			}
			ds_list_destroy(visitedRooms);
		}
		//print("hello???")
	});
	print("monetttttyy");
	//print(ds_grid_get(dungeonGrid,6,5));
}

function roomLooper(originX,originY,visitedRooms,blockedDirection = -1, origin = [0,0]){
	for (var i = 0; i < 4; i++){
		if i != blockedDirection{
			var result = checkAdjacentRooms_helper(originX,originY,i)
			if result[4] == 1{
				if origin[0] == 5 && origin[1] == 6{
					print(i)
					print(originX)
					print(originY)
					print(ds_list_find_index(visitedRooms,result[0].roomID))
					print("We have a match!")
				}
				if result[0].connectedToStart{
					return true;
				}else{
					if ds_list_find_index(visitedRooms,result[0].roomID) == -1{
						ds_list_add(visitedRooms,result[0].roomID);
						var xY = directionToXY(i);
						//print("Lets dig deeper");
						if roomLooper(originX+xY[0],originY+xY[1],visitedRooms,directionToXY( (i+2) mod 4), origin ){
							print("yipee");
							return true
						}else{
							//print("darn");
						}
					}
				}
			}
			//print("-----");
		}
	}
	return false
}

function deleteRoom(_x,_y){
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
			print("somethinwrongiholdmyheadmjgone")
		}else{
			adjacentRooms[0][i] = 0;
		}
	}
}


function createRoom(_x,_y){
	if _x == 5 && _y == 5{ //todo: make this not hardcoded, i.e. make it depend on where the middle is based on stage
		ds_grid_set(dungeonGrid, _x,_y, {_room : rm_startingRoom, doors : [1,1,1,1], connectedToStart : true, edge: false,roomID : uniqueIDGiver})
	}else{
		var adjacentDoors = checkAdjacentRooms(_x,_y)[0]
		for (var i = 0; i < 3; i++){
			if adjacentDoors[i] == -2{
				adjacentDoors[i] = random(1) < 0.39
			}
		}

		ds_grid_set(dungeonGrid, _x,_y, {_room : rm_roomTemplate, doors : adjacentDoors, connectedToStart : false, edge: false,roomID : uniqueIDGiver})
	}
}
function checkAdjacentRooms_helper(_x,_y,_direction){
	
	var adjacentRoom = [undefined,-9,-9,-9,-9]
	try{
		//directionToXY
		if _direction == 0{
			adjacentRoom = ds_grid_get(dungeonGrid, _x+1, _y)
			return [adjacentRoom, -1, 0, adjacentRoom.connectedToStart, adjacentRoom.doors[(_direction+2) mod 4]]
		}else if _direction == 1{
			adjacentRoom = ds_grid_get(dungeonGrid, _x, _y-1)
			return [adjacentRoom, 0, 1 , adjacentRoom.connectedToStart, adjacentRoom.doors[(_direction+2) mod 4]]
		}else if _direction == 2{
			adjacentRoom = ds_grid_get(dungeonGrid, _x-1, _y)
			return [adjacentRoom, 1 , 0, adjacentRoom.connectedToStart, adjacentRoom.doors[(_direction+2) mod 4]]
		}else if _direction == 3{
			adjacentRoom = ds_grid_get(dungeonGrid, _x, _y+1)
			return [adjacentRoom, 0, -1, adjacentRoom.connectedToStart, adjacentRoom.doors[(_direction+2) mod 4]]
		}
	}catch(e){
		var adjacentRoo = [undefined,-9,-9,-9,-9]
		//print("Nothing here");
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

