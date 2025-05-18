dungeonSize = 10; 
currentRoom = [dungeonSize/2,dungeonSize/2];
uniqueIDGiver = 0;
dungeonGrid = ds_grid_create(dungeonSize, dungeonSize);

generateDungeon();

function enterNewRoom(xDirection, yDirection){
	print(playerTank.y);
	currentRoom = [currentRoom[0]+xDirection,currentRoom[1]+yDirection];
	if (currentRoom[0] > dungeonSize || currentRoom[0] < 0 || currentRoom[1] > dungeonSize || currentRoom[1] < 0){
		room_goto(rm_errorRoom);
	}else{
		var newRoom = ds_grid_get(dungeonGrid, currentRoom[0], currentRoom[1])
		currentRoomHandler.roomDoors = newRoom.doors;
		print(newRoom.doors);
		print(newRoom._room)
		room_goto(newRoom._room);
	}
	playerTank.x = playerTank.x-room_width*xDirection+(playerTank.sprite_width)*xDirection 
	playerTank.y = playerTank.y-room_height*yDirection+(playerTank.sprite_height)*yDirection 
}



