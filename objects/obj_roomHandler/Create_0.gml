dungeonSize = 10; 
currentRoom = [dungeonSize/2,dungeonSize/2];
uniqueIDGiver = 0;
dungeonGrid = ds_grid_create(dungeonSize, dungeonSize);
allRooms = 0;

generateDungeon();


function enterNewRoom(xDirection, yDirection){
	print(playerTank.y);
	currentRoom = [currentRoom[0]+xDirection,currentRoom[1]+yDirection];
	var newRoom = ds_grid_get(dungeonGrid, currentRoom[0], currentRoom[1])
	if inRange(currentRoom[0], 0, dungeonSize) && inRange(currentRoom[1],0,dungeonSize) && !is_undefined(newRoom) && newRoom != noone{
		
		currentRoomHandler.roomDoors = newRoom.doors;
		print(newRoom.doors);
		print(newRoom._room)
		room_goto(newRoom._room);
	}else{
		currentRoom = [-666,-666];
		room_goto(rm_errorRoom);
	}
	playerTank.x = playerTank.x-room_width*xDirection+(playerTank.sprite_width+24)*xDirection 
	playerTank.y = playerTank.y-room_height*yDirection+(playerTank.sprite_height+24)*yDirection 
}



