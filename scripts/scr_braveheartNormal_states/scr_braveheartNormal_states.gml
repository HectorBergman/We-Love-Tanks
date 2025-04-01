function braveheartNormal_approaching(){
	nearestCrumb = noone;
	nearestCrumbDistance = 99999999;
	wallSeen = 0;

	tick--;
	distance = point_distance(x, y, playerTank.x, playerTank.y);
	distanceX = abs(playerTank.x - x);
	distanceY = abs(playerTank.y - y);
	
	
	var arr = findNearbyCrumbs()
	nearestCrumb = arr[0];
	nearestCrumbDistance = arr[1];
	if (nearestCrumb != noone) {
		// Get direction to target
		var dir = point_direction(x, y, nearestCrumb.x, nearestCrumb.y);
    
		// Calculate movement vector
		movementVector[0] = lengthdir_x(movementSpeed, dir);
		movementVector[1] = lengthdir_y(movementSpeed, dir);
			if (place_meeting(x + movementX(), y, [obj_wall, obj_player, obj_enemy])){
			var _hStep = sign(movementX());
			stepCollisionWhileWithFailCon([obj_wall, obj_enemy, obj_player], _hStep, true)
			movementVector[0] = 0;
		}
		if (place_meeting(x, y + movementY(), [obj_wall, obj_player, obj_enemy])){
			var _vStep = sign(movementY());
			stepCollisionWhileWithFailCon([obj_wall, obj_enemy, obj_player], _vStep, false)
			movementVector[1] = 0;
		}
		if (movementVector[0] != 0 || movementVector[1] != 0){
			hitbox.image_angle = point_direction(x,y,x + movementVector[0]*movementSpeed, y + movementVector[1]*movementSpeed)
		}


		x += movementVector[0]
		y += movementVector[1];

	}else{
		state = braveheartNormal.patrolling
	}
	
	


}

function braveheartNormal_patrolling(){
	
	if !collision_line(x,y,playerTank.x,playerTank.y, obj_wall,0,1){
		var arr = findNearbyCrumbs()
		nearestCrumb = arr[0];
		if (nearestCrumb == noone){
			
		}else{
			state = braveheartNormal.approaching
		}
	}else{
		state = braveheartNormal.spotted
	}
	
}

function braveheartNormal_spotted(){
	if !collision_line(x,y,playerTank.x,playerTank.y, obj_wall,0,1){
		var dir = point_direction(x, y, playerTank.x, playerTank.y);
		movementVector[0] = lengthdir_x(movementSpeed, dir);
		movementVector[1] = lengthdir_y(movementSpeed, dir);
	}else{
		state = braveheartNormal.approaching
	}
}