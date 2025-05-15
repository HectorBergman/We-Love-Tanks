function generateDungeon(){
	ds_grid_clear(dungeonGrid,noone)//, {_room : rm_errorRoom, doors : [0,0,0,0]});
	ds_grid_set(dungeonGrid, currentRoom[0],currentRoom[1], {_room : rm_startingRoom, doors : [1,1,1,1]});
	for (var i = 0; i < dungeonSize+1; i++){
		for (var j = 0; j < dungeonSize+1; j++){
			createRoom(i,j);
		}
	}
}

function createRoom(_x,_y){
	var adjacentRooms = checkAdjacentRooms(_x,_y); 
	var adjacentRoomsCounter = 0;
	for (var i = 0; i < 4; i++){
		if adjacentRooms[i] == 1 || adjacentRooms[i] == -2{
			adjacentRoomsCounter++
			adjacentRooms[i] = 1;
		}else{
			adjacentRooms[i] = 0;
		}
	}
	if adjacentRoomsCounter > 0{
		ds_grid_set(dungeonGrid, _x,_y, {_room : rm_roomTemplate, doors : adjacentRooms})
	}
}
function checkAdjacentRooms_helper(_x,_y,_direction){
	try{
		if _direction == 0{
			return [ds_grid_get(dungeonGrid, _x+1, _y), -1, 0]
		}else if _direction == 1{
			return [ds_grid_get(dungeonGrid, _x, _y-1), 0, 1 ]
		}else if _direction == 2{
			return [ds_grid_get(dungeonGrid, _x-1, _y), 1, 0 ]
		}else if _direction == 3{
			return [ds_grid_get(dungeonGrid, _x, _y+1), 0, -1]
		}
	}catch(e){
		print(e);
		return [undefined, 0, 0]
	}
}
//returns an array of 4 bools,
//index 0 = right, index 1 = up, index 2 = left, index 3 = down
//if true, means a room with an open door exists there
// 0 means room exists there but has closed door
//-1 means room is outside of dungeon area
//-2 means room has not been generated yet
function checkAdjacentRooms(_x,_y){
	var returnArray = [0,0,0,0]
	for (var i = 0; i < 4; i++){
		var result = checkAdjacentRooms_helper(_x,_y,i)
		if !(result[0] == undefined || result[0] == -4) {
			print(result)
			print(result[0]);
			print((i+2) mod 4)
			print("----");
			if result[0].doors[(i+2) mod 4] == 1{
				if result[0]._room != rm_errorRoom{
					returnArray[i] = 1;
				}
				else{
					returnArray[i] = -1;
				}
				//createRoom(_x+result[0],_y+result[1])
			}else{
				returnArray[i] = 0;
			}
		}else{ returnArray[i] = -2
		}
	}
	return returnArray
}

