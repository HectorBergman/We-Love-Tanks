PAUSE
if instance_exists(obj_currentRoomHandler){

	if obj_currentRoomHandler.roomDoors[roomNo][_direction] == 1{
		if obj_currentRoomHandler.lock == false{
			image_index = 1;
		}else{
			image_index = 0;
		}
		
	}else if obj_currentRoomHandler.roomDoors[roomNo][_direction] == 0{
		sprite_index = spr_wall;
	}else if obj_currentRoomHandler.roomDoors[roomNo][_direction] == 2{
		instance_change(obj_lock_boss, true);
	}
}else{
	sprite_index = spr_wall;
}