pauseMode = [pM.pauseMenu];
collideable = true;

enum doorModes{
	open,
	locked,
	wall,
}
mode = doorModes.wall
SignalSubscribe(id, "doors:",function(info){
	var relevantDoor = info[0][roomNo][_direction]
	if relevantDoor == doorValues.open{
		if info[1] ||(
			instance_number(obj_enemy) == 0 && instance_number(obj_enemySpawner) == 0 &&
			instance_number(obj_boss)  == 0 && instance_number(obj_bossSpawner)  == 0
		){
			image_index = 1;
			mode = doorModes.open
		}else{
			image_index = 0;
			mode = doorModes.locked
		}
	}else if relevantDoor == doorValues.closed{
		sprite_index = spr_wall;
		mode = doorModes.wall
	}
})
SignalSubscribe(id, "clearedStatus", function(isCleared){
	if isCleared && mode != doorModes.wall{
		mode = doorModes.open
		image_index = 1;
	}
})