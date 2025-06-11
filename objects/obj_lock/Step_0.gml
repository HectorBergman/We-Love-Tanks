PAUSE
if instance_exists(obj_currentRoomHandler){
	if obj_currentRoomHandler.roomDoors[_direction] != 1{
	
		sprite_index = spr_wall;
	}else{
		if obj_currentRoomHandler.lock == false{
			image_index = 1;
		}else{
			image_index = 0;
		}
	}
}else{
	sprite_index = spr_wall;
}