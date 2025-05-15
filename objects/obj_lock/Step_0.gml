if currentRoomHandler.roomDoors[_direction] == 0{
	image_index = 0;
}else{
	if currentRoomHandler.lock == false{
		image_index = 1;
	}else{
		image_index = 0;
	}
}