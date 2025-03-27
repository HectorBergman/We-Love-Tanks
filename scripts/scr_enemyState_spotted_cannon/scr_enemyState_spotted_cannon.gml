function enemyState_spotted_cannon(){
	if (!collision_line(x, y, playerTank.x, playerTank.y, obj_wall, false, true)){
		image_angle = image_angle mod 360;
		var goalDirection = point_direction(x,y,playerTank.x, playerTank.y) mod 360;
		var turnDirection = 0
		if (goalDirection-image_angle > 180 || (goalDirection-image_angle < 0 && goalDirection-image_angle > -180)){
			turnDirection = -1
		}else{
			turnDirection = 1
		}
		print(turnDirection);
	
		if (is_in_range(image_angle,goalDirection-2, goalDirection+2)){
			state = cannonEnemyStates.normal;
		}else{
			image_angle = (image_angle + turnDirection*radtodeg(scanningStep)) mod 360
		}
	
	}else{
		state = cannonEnemyStates.scanning;
		stepsTilSwitch = 50;
	} 
}

