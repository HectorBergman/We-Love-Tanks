pauseMode = [pM.pauseMenu];
collideable = true;

enum doorModes{
	open,
	locked,
	wall,
}

actionList = ds_list_create();
mode = doorModes.wall
SignalSubscribe(id, "doors:",function(info){
	var relevantDoor = info[0][roomNo][_direction]
	if relevantDoor == doorValues.open{
		if info[1] ||(
			instance_number(obj_enemy) == 0 && instance_number(obj_enemySpawner) == 0 &&
			instance_number(obj_boss)  == 0 && instance_number(obj_bossSpawner)  == 0
		){
			setLock(false)
		}else{
			setLock(true);
		}
	}else if relevantDoor == doorValues.closed{
		sprite_index = spr_wall;
		mode = doorModes.wall
	}
})
SignalSubscribe(id, "clearedStatus", function(isCleared){
	if isCleared && mode != doorModes.wall{
		setLock(false)
	}
})

function setLock(lock = true){
	if lock{
		image_index = 0;
		mask_index = spr_lock
		mode = doorModes.locked
	}else{
		image_index = 1;
		mask_index = spr_lock_boss
		mode = doorModes.open
	}
}