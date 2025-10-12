
function braveheartNormal_firing_cannon(){
	
	firingCooldown--
	if !(collision_line(x, y, obj_player.x, obj_player.y, obj_solid, false, true)){
		image_angle = point_direction(x,y,obj_player.x,obj_player.y)

	}else{
		state = stiffNormal_cannon.scanning;
		scanningPoint = image_angle
		scanningDirection = sign(random_range(-1, 1));

	}
	if !place_meeting(x,y, obj_solid) && activeBullets < 3 && firingCooldown < 1{
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
			20, 
			bulletInfo.durability,
			extraInfo
		)
		fireBullet(id,obj_bullet_enemy,image_angle,args)
	}
}
function braveheartNormal_scanning_cannon(){
	if (collision_line(x, y, obj_player.x, obj_player.y, obj_solid, false, true)){
		if (parent.movementVector[0] != 0 || parent.movementVector[1] != 0){
			var goalDirection = point_direction(x,y,x+parent.movementVector[0], y+parent.movementVector[1])
			var gradPoint = gradualPoint(goalDirection,image_angle, 0.05);
			image_angle = gradPoint;
		}
	}else{
		state = braveheartNormal_cannon.spotted;
		stepsTilSwitch = 50;
	}
}
function braveheartNormal_spotted_cannon(){
	if (!collision_line(x, y, obj_player.x, obj_player.y, obj_solid, false, true)){
		
	
		var goalDirection = point_direction(x,y,obj_player.x, obj_player.y)
		var gradPoint = gradualPoint(goalDirection,image_angle, 0.05);
		image_angle = gradPoint;
		if (gradPoint == goalDirection){
			state = braveheartNormal_cannon.firing;
		}
	
	}else{
		state = braveheartNormal_cannon.scanning;
	}
	
}