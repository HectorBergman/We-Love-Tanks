mapWidth = 192
mapHeight = 108
x = 1920-192*1.5
y = 0+108
scale = 0.5;

depth = -10;
rectangleWidth = 35*scale
rectangleHeight = 18*scale;
doorWidth = 4*scale;
doorHeight = 4*scale;

processRoomCell = function(i, j) {
    createRoom(i, j);     
    uniqueIDGiver++;        
};


roomsToDisplay = ds_grid_create(5,5);
currentRoom = obj_roomHandler.currentRoom

function getRoomsToDisplay(){
	currentRoom = obj_roomHandler.currentRoom
	ds_grid_clear(roomsToDisplay, undefined)
	for (var i = -2; i < 3; i++){
		for (var j = -2; j < 3; j++){
			if (inRange(currentRoom[0]+i,0,9) && inRange(currentRoom[1]+j,0,9)){
				var doors = ds_grid_get(obj_roomHandler.dungeonGrid,currentRoom[0]+i,currentRoom[1]+j)
				/*if !is_undefined(doors) && doors != noone{
					doors = doors.doors
				}*/
				ds_grid_set(roomsToDisplay,i+2,j+2,doors)
			}		
		}
	}
}
getRoomsToDisplay();