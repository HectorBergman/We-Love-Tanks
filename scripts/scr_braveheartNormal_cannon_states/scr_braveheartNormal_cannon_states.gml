
function braveheartNormal_firing_cannon(){
	
	firingCooldown--
	if !(collision_line(x, y, obj_player.x, obj_player.y, obj_solid, false, true)){
		image_angle = point_direction(x,y,obj_player.x,obj_player.y)

	}else{
		state = stiffNormal_cannon.scanning;
		scanningPoint = image_angle
		scanningDirection = sign(random_range(-1, 1));

	}
	if !place_meeting(x,y, obj_solid) && activeBullets < 3 && firingCooldown < 1{
		fireBullet(obj_bullet_enemy, 1.5, 3, 1, image_angle,20,true, 1)	
		
	}
}
function braveheartNormal_scanning_cannon(){
	if (collision_line(x, y, obj_player.x, obj_player.y, obj_solid, false, true)){
		if (parent.movementVector[0] != 0 || parent.movementVector[1] != 0){
			var goalDirection = point_direction(x,y,x+parent.movementVector[0], y+parent.movementVector[1])
			if (gradualPoint(goalDirection, 0.05)){
				image_angle = goalDirection;
			}
		}
	}else{
		state = braveheartNormal_cannon.spotted;
		stepsTilSwitch = 50;
	}
}
function braveheartNormal_spotted_cannon(){
	if (!collision_line(x, y, obj_player.x, obj_player.y, obj_solid, false, true)){
		
	
		var goalDirection = point_direction(x,y,obj_player.x, obj_player.y)
		if (gradualPoint(goalDirection, 0.05)){
			image_angle = goalDirection;
			state = braveheartNormal_cannon.firing;
		}
	
	}else{
		state = braveheartNormal_cannon.scanning;
	}
	
}