PAUSE
if !(parent.movementVector[0] == 0 && parent.movementVector[1] == 0){
	wheelturnTimer++
	if wheelturnTimer mod ceil(20/parent.movementSpeed) == 0{
		currentWheelFrame++
		currentWheelFrame = currentWheelFrame mod 3
		sprite_index = asset_get_index("spr_player_tank_wheels_" + string(currentWheelFrame));
	}
}

if parent.invincible{
	if parent.invincibilityFrames mod 15 >= 10{
		image_alpha = 0.2;
		
	}else{
		image_alpha = 1;
	}
}else{
	image_alpha = 1;
}
cannon.image_alpha = image_alpha;