PAUSE
SignalSubscribe(id, "doors:",function(arg){
	var relevantDoor = arg[_direction]
	if relevantDoor == doorValues.open{
		image_index = 1;
	}else if relevantDoor == doorValues.closed{
		sprite_index = spr_wall;
	}
})
/*if instance_exists(obj_currentRoomHandler){
	var relevantDoor = obj_currentRoomHandler.roomDoors[roomNo][_direction]
	if relevantDoor == doorValues.open ||
		relevantDoor == doorValues.openToShop{
		if obj_currentRoomHandler.lock == false{
			image_index = 1;
		}else{
			image_index = 0;
		}
		
	}else if relevantDoor == doorValues.closed{
		sprite_index = spr_wall;
	}else if relevantDoor == doorValues.openToNewStage{
		instance_change(obj_lock_boss, true);
	}
}else{
	sprite_index = spr_wall;
}