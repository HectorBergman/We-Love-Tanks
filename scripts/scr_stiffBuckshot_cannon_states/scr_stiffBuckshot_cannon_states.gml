function stiffBuckshot_cannon_firing(){
	
	firingCooldown--
	if !(collision_line(x, y, obj_player.x, obj_player.y, obj_solid, false, true)){
		image_angle = point_direction(x,y,obj_player.x,obj_player.y)

	}else{
		state = stiffBuckshot_cannon.scanning;
		rapidCooldown = 0;
		scanningPoint = image_angle
		scanningDirection = sign(random_range(-1, 1));

	}
	var hasbullets = false;
	for (var i = 0; i < array_length(buckshotBullets); i++){
		var bullet = buckshotBullets[i]
		if instance_exists(buckshotBullets[i]){
			hasbullets = true;
			break;
		}else if i == array_length(buckshotBullets)-1{
			buckshotBullets = [];
		}
	}
	if !place_meeting(x,y, obj_solid) && activeBullets < 1 && firingCooldown < 1 && !hasbullets{
		var extraInfo = {
			bulletGrowthStart: 0.3, 
			bulletGrowthEnd: 1, 
			bulletGrowthRate: 0.05,
			tags:["buckshot"],
			buckshotSpread:45,
			buckshotCount:4,
			buckshotTime:30,
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
	}
}

function stiffBuckshot_cannon_scanning(){
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
		state = stiffBuckshot_cannon.spotted;
		stepsTilSwitch = 50;
	}
}

function stiffBuckshot_cannon_spotted(){
	if (!collision_line(x, y, obj_player.x, obj_player.y, obj_solid, false, true)){

		var goalDirection = point_direction(x,y,obj_player.x, obj_player.y)
		var gradPoint = gradualPoint(goalDirection,image_angle, 0.02);
		image_angle = gradPoint;
		if (gradPoint == goalDirection){
			state = stiffBuckshot_cannon.firing;
		}
	}else{
		state = stiffBuckshot_cannon.scanning;
		stepsTilSwitch = 50;
	} 
}