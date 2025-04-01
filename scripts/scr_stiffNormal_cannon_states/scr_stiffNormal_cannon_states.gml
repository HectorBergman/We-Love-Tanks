function stiffNormal_cannon_firing(){
	firingCooldown--
	if !(collision_line(x, y, playerTank.x, playerTank.y, obj_wall, false, true)){
		image_angle = point_direction(x,y,playerTank.x,playerTank.y)

	}else{
		state = stiffNormal_cannon.scanning;
		scanningPoint = image_angle
		scanningDirection = sign(random_range(-1, 1));

	}
	if !place_meeting(x,y, obj_wall) && activeBullets < 3 && firingCooldown < 1{
		fireBullet(obj_bullet_enemy, 1.5, 3)	
	}
}

function stiffNormal_cannon_scanning(){
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
		state = stiffNormal_cannon.spotted;
		stepsTilSwitch = 50;
	}
}

function stiffNormal_cannon_spotted(){
	if (!collision_line(x, y, playerTank.x, playerTank.y, obj_wall, false, true)){

		var goalDirection = point_direction(x,y,playerTank.x, playerTank.y)
		if (gradualPoint(goalDirection, 0.02)){
			state = stiffNormal_cannon.firing;
		}
	}else{
		state = stiffNormal_cannon.scanning;
		stepsTilSwitch = 50;
	} 
}