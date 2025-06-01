PAUSE
if currentRoomHandler.roomDoors[_direction] != 1{
	
	sprite_index = spr_wall;
}else{
	if currentRoomHandler.lock == false{
		image_index = 1;
	}else{
		image_index = 0;
	}
}