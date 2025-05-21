mapWidth = 192
mapHeight = 108
x = 1920-192*1.5
y = 0+108

rectangleWidth = 35
rectangleHeight = 18;
doorWidth = 4;
doorHeight = 4;
updateMap = true;

roomsToDisplay = ds_grid_create(5,5);
currentRoom = roomHandler.currentRoom

function getRoomsToDisplay(){
	ds_grid_clear(roomsToDisplay, undefined)
	for (var i = -2; i < 3; i++){
		for (var j = -2; j < 3; j++){
			if (inRange(currentRoom[0]+i,0,9) && inRange(currentRoom[1]+j,0,9)){
				var doors = ds_grid_get(roomHandler.dungeonGrid,currentRoom[0]+i,currentRoom[1]+j)
				if !is_undefined(doors) && doors != noone{
					doors = doors.doors
				}
				ds_grid_set(roomsToDisplay,i+2,j+2,doors)
			}
			
				
		}
	}
}
