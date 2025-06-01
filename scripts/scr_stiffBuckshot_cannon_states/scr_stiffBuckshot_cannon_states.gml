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
		print("weinhere");
		var bullet = buckshotBullets[i]
		if instance_exists(buckshotBullets[i]){
			hasbullets = true;
			break;
		}else if i == array_length(buckshotBullets)-1{
			buckshotBullets = [];
		}
	}
	if !place_meeting(x,y, obj_solid) && activeBullets < 1 && firingCooldown < 1 && !hasbullets{
		print(point_direction(x,y,obj_player.x,obj_player.y))
		print(image_angle);
		print("penniiiis");
		fireBullet(obj_bullet_enemy, 1.5, 3, 1,image_angle, 20,true, [["tags",["buckshot"]],["buckshotSpread", 45],["buckshotCount",4],["buckshotTime",30]])	

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
		if (gradualPoint(goalDirection, 0.02)){
			state = stiffBuckshot_cannon.firing;
		}
	}else{
		state = stiffBuckshot_cannon.scanning;
		stepsTilSwitch = 50;
	} 
}