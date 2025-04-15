dungeonSize = 10; 
currentRoom = [dungeonSize/2,dungeonSize/2];

dungeonGrid = ds_grid_create(dungeonSize, dungeonSize);

ds_grid_clear(dungeonGrid, {_room : rm_test1});
ds_grid_set(dungeonGrid, currentRoom[0],currentRoom[1], {_room : rm_startingRoom});

function enterNewRoom(xDirection, yDirection){

	currentRoom = [currentRoom[0]+xDirection,currentRoom[1]+yDirection];
	room_goto(ds_grid_get(dungeonGrid, currentRoom[0], currentRoom[1])._room);
	playerTank.x = playerTank.x-room_width mod room_width;
	playerTank.y = playerTank.y-room_height mod room_height;
}



