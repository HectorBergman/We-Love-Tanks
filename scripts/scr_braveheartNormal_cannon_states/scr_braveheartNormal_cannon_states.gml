
function braveheartNormal_firing_cannon(){
	stiffNormal_cannon_firing()
}
function braveheartNormal_scanning_cannon(){
	if (collision_line(x, y, playerTank.x, playerTank.y, [obj_wall, obj_enemy], false, true)){
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
	if (!collision_line(x, y, playerTank.x, playerTank.y, [obj_wall, obj_enemy], false, true)){
		
	
		var goalDirection = point_direction(x,y,playerTank.x, playerTank.y)
		if (gradualPoint(goalDirection, 0.05)){
			image_angle = goalDirection;
			state = braveheartNormal_cannon.firing;
		}
	
	}else{
		state = braveheartNormal_cannon.scanning;
	}
	
}