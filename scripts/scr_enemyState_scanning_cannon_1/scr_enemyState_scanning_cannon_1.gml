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

