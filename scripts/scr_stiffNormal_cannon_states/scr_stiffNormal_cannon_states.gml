function stiffNormal_cannon_firing(){
	rapidCooldown--;
	firingCooldown--
	if !(collision_line(x, y, obj_player.x, obj_player.y, obj_solid, false, true)){
		image_angle = point_direction(x,y,obj_player.x,obj_player.y)

	}else{
		state = stiffNormal_cannon.scanning;
		rapidCooldown = 0;
		scanningPoint = image_angle
		scanningDirection = sign(random_range(-1, 1));

	}
	if rapidCooldown > rapidCooldownLimit{
		rapidCool = true;
	}
	if rapidCooldown < 0{
		rapidCool = false;
	}
	if !place_meeting(x,y, obj_solid) && activeBullets < 3 && firingCooldown < 1 && !rapidCool{
		fireBullet(obj_bullet_enemy, 1.5, 3, 1, image_angle,20,true, 1)	
		rapidCooldown += 90;
	}
}

function stiffNormal_cannon_scanning(){
	if (collision_line(x, y, obj_player.x, obj_player.y, obj_solid, false, true)){
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
	if (!collision_line(x, y, obj_player.x, obj_player.y, obj_solid, false, true)){

		var goalDirection = point_direction(x,y,obj_player.x, obj_player.y)
		if (gradualPoint(goalDirection, 0.02)){
			state = stiffNormal_cannon.firing;
		}
	}else{
		state = stiffNormal_cannon.scanning;
		stepsTilSwitch = 50;
	} 
}