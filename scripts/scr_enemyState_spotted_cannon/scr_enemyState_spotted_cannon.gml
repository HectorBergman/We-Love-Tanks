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
	
	if (abs(angle_difference(targetAngle, image_angle)) < abs(radtodeg(turningSpeed*pi/2))*2){
		return true; 
	}else{
		image_angle = (image_angle + radtodeg(turnDirection*pi/2*turningSpeed))
		return false;
	}
	
	
}

/// @function gradualPointOverTime(goalDirection,turningSpeed)
/// @description Returns the angle needed every step to go from current image_angle to target angle.
/// @param {real} targetAngle Target angle, given in degrees
/// @param {real} steps Amount of steps to reach target angle
/// @returns {real} The angle to be added over (steps) steps

function gradualPointOverTime(targetAngle, steps){
	var turnDirection = sign(angle_difference(targetAngle, image_angle))
	return angle_difference(targetAngle, image_angle)/steps; 
}

