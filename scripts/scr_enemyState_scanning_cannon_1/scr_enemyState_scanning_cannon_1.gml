function enemyState_scanning_cannon(){
	if (collision_line(x, y, playerTank.x, playerTank.y, obj_wall, false, true)){
		if stepsTilSwitch > 0{
			image_angle = radtodeg(degtorad(image_angle) + scanningDirection*scanningStep)
		}else{
			scanningDirection = scanningDirection*-1
			image_angle = radtodeg(degtorad(image_angle) + scanningDirection*scanningStep)
			stepsTilSwitch = stepTilSwitchWhole;
		}
		stepsTilSwitch--
	}else{
		state = cannonEnemyStates.spotted;
		stepsTilSwitch = 50;
	}
}

//scanning cannons for moving enemies
function enemyState_scanning_cannon_moving(){
	if (collision_line(x, y, playerTank.x, playerTank.y, obj_wall, false, true)){
		if (parent.movementVector[0] != 0 || parent.movementVector[1] != 0){
			var goalDirection = point_direction(x,y,x+parent.movementVector[0], y+parent.movementVector[1])
			if (gradualPoint(goalDirection, 0.05)){
				image_angle = goalDirection;
			}
		}
	}else{
		state = cannonEnemyStates.spotted;
		stepsTilSwitch = 50;
	}
}

