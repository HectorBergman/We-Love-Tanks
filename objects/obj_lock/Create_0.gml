pauseMode = [pM.pauseMenu];
collideable = true;
enum doorModes{
	open,
	locked,
	wall,
}
mode = doorModes.wall
SignalSubscribe(id, "doors:",function(doors){
	var relevantDoor = doors[_direction]
	
	if relevantDoor == doorValues.open{
		image_index = 1;
		mode = doorModes.open
	}else if relevantDoor == doorValues.closed{
		sprite_index = spr_wall;
		mode = doorModes.wall
	}
})
SignalSubscribe(id, "clearedStatus", function(isCleared){
	print("clearedStatus received ",isCleared)
	if isCleared && mode != doorModes.wall{
		mode = doorModes.open
		image_index = 1;
	}
})