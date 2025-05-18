function generateDungeon(){
	ds_grid_clear(dungeonGrid,noone)//, {_room : rm_errorRoom, doors : [0,0,0,0]});
	spiralGridScan(currentRoom[0],currentRoom[1],10,10,function(i,j) {
		createRoom(i,j);
	});
	for (var i = 0; i < 10; i++){
		for (var j = 0; j < 10; j++){
		}
	}
	
}


function createRoom(_x,_y){
	var adjacentRooms = checkAdjacentRooms(_x,_y); 
	var adjacentRoomsCounter = 0;
	for (var i = 0; i < 4; i++){
		if adjacentRooms[0][i] == 1{
			adjacentRoomsCounter++
			adjacentRooms[0][i] = 1;
		}else if adjacentRooms[i] == -2{
			if irandom(4) == 4{
				adjacentRoomsCounter++
				adjacentRooms[0][i] = 1;
			}else{
				adjacentRooms[0][i] = 0;
			}
		}else{
			adjacentRooms[0][i] = 0;
		}
	}
	if adjacentRoomsCounter > 0{
		ds_grid_set(dungeonGrid, _x,_y, {_room : rm_roomTemplate, doors : adjacentRooms[0], connectedToStart : adjacentRooms[1][3], edge: false})
	}
}
function checkAdjacentRooms_helper(_x,_y,_direction){
	var adjacentRoom = [undefined,0,0,0]
	try{
		if _direction == 0{
			adjacentRoom = ds_grid_get(dungeonGrid, _x+1, _y)
			return [adjacentRoom, -1, 0, adjacentRoom.connectedToStart]
		}else if _direction == 1{
			adjacentRoom = ds_grid_get(dungeonGrid, _x, _y-1)
			return [adjacentRoom, 0, 1, adjacentRoom.connectedToStart ]
		}else if _direction == 2{
			adjacentRoom = ds_grid_get(dungeonGrid, _x-1, _y)
			return [adjacentRoom, 1, 0, adjacentRoom.connectedToStart ]
		}else if _direction == 3{
			adjacentRoom = ds_grid_get(dungeonGrid, _x, _y+1)
			return [adjacentRoom, 0, -1, adjacentRoom.connectedToStart]
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

