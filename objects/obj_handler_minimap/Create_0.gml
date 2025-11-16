mapWidth = 192
mapHeight = 108
x = 1920-192*1.5
y = 0+108
scale = 0.5;

depth = -10;
rectangleWidth = 32*scale
rectangleHeight = 18*scale;
doorWidth = 4*scale;
doorHeight = 4*scale;




roomsToDisplay = ds_grid_create(5,5);
ds_grid_clear(roomsToDisplay, noone)
SignalSubscribe(id, "update: currentRoom", function(arg){print("updatingRoom");currentRoom = arg;})
SignalSubscribe(id, "update: currentFloor", function(arg){print("updatingFloor");currentFloor = arg;})
SignalSubscribe(id, "update: currentDungeon", function(arg){print("updatingDungeon");currentDungeon = arg;})
SignalSubscribe(id, "update: minimap", function(){print("updatingminimap");getRoomsToDisplay()})
SignalSend("minimap");




function getRoomsToDisplay(){
	ds_grid_clear(roomsToDisplay, noone)
	for (var i = -2; i < 3; i++){
		for (var j = -2; j < 3; j++){
			if (inRange(currentRoom.coords[0]+i,0,currentFloor.dimensions[0]-1) && 
				inRange(currentRoom.coords[1]+j,0,currentFloor.dimensions[1]-1)){
				var relevantRoom = ds_grid_get(currentFloor.grid,currentRoom.coords[0]+i,currentRoom.coords[1]+j)
				if roomExists(relevantRoom){
					ds_grid_set(roomsToDisplay,i+2,j+2,relevantRoom)
				}else{
					ds_grid_set(roomsToDisplay,i+2,j+2,noone)
				}
			}else{
				ds_grid_set(roomsToDisplay,i+2,j+2,noone)
			}
		}
	}
}