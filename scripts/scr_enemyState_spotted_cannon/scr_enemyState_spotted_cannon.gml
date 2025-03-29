function enemyState_spotted_cannon(){
	if (!collision_line(x, y, playerTank.x, playerTank.y, obj_wall, false, true)){

		var goalDirection = point_direction(x,y,playerTank.x, playerTank.y)
		if (gradualPoint(goalDirection, 0.02)){
			state = cannonEnemyStates.normal;
		}
	}else{
		state = cannonEnemyStates.scanning;
		stepsTilSwitch = 50;
	} 
}

function enemyState_spotted_cannon_moving(){
	if (!collision_line(x, y, playerTank.x, playerTank.y, obj_wall, false, true)){
		
	
		var goalDirection = point_direction(x,y,playerTank.x, playerTank.y)
		if (gradualPoint(goalDirection, 0.05)){
			image_angle = goalDirection;
			state = cannonEnemyStates.normal;
		}
	
	}else{
		state = cannonEnemyStates.scanning;
		stepsTilSwitch = 50;
	} 
}

/// @function gradualPoint(goalDirection,turningSpeed)
/// @description Gradually changes image_angle to target angle instead of snapping
/// @param {real} targetAngle Target angle, given in degrees
/// @param {real} turningSpeed Rate of turning, turningSpeed = 1 means spinning pi/2 per tick. So try to keep it below 1, preferably even below 0.1
/// @returns {bool} True if it has locked onto targetAngle, else returns false

function gradualPoint(targetAngle, turningSpeed){
	//var goalDirection = point_direction(x,y,playerTank.x, playerTank.y) mod 360;
	var turnDirection = sign(angle_difference(targetAngle, image_angle))
	print("----------------");
	print(angle_difference(targetAngle, image_angle));
	print(targetAngle)
	print(image_angle);
	print(turningSpeed*pi/2);
	print(turnDirection);
	if (abs(angle_difference(targetAngle, image_angle)) < abs(radtodeg(turningSpeed*pi/2))*2){
		return true; 
	}else{
		image_angle = (image_angle + radtodeg(turnDirection*pi/2*turningSpeed))
		return false;
	}
	
	
}
