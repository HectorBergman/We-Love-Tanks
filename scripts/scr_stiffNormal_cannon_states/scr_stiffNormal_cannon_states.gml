function stiffNormal_cannon_firing(){
	rapidCooldown--;
	firingCooldown--
	if !(collision_line(x, y, obj_player.x, obj_player.y, obj_solid, false, true)){
		image_angle = point_direction(x,y,obj_player.x,obj_player.y)

	}else{
		state = states.scanning;
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
		var extraInfo = {
			bulletGrowthStart: 0.3, 
			bulletGrowthEnd: 1, 
			bulletGrowthRate: 0.05,
		}

		var args = 
		fireBullet_defaultSummonStruct(
			bulletInfo.speed,
			bulletInfo.bounces,
			bulletInfo.damage,
			enemyBarrelLength, 
			bulletInfo.durability,
			extraInfo
		)
		fireBullet(id,obj_bullet_enemy,image_angle,args)
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
		state = states.spotted;
		stepsTilSwitch = 50;
	}
}

function stiffNormal_cannon_spotted(){
	if (!collision_line(x, y, obj_player.x, obj_player.y, obj_solid, false, true)){

		var goalDirection = point_direction(x,y,obj_player.x, obj_player.y)
		var gradPoint = gradualPoint(goalDirection,image_angle, 0.02);
		image_angle = gradPoint;
		if (gradPoint == goalDirection){
			state = states.firing;
		}
	}else{
		state = states.scanning;
		stepsTilSwitch = 50;
	} 
}