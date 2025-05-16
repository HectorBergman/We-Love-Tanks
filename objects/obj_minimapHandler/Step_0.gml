if currentRoom != roomHandler.currentRoom{
	currentRoom = roomHandler.currentRoom
	getRoomsToDisplay();
	updateMap = true;
}else{
	updateMap = false;
}
