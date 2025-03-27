function enemyState_prowling(){
	
	for (var i = 0; i < instance_number(obj_breadCrumbs); ++i;){
		var breadCrumb = instance_find(obj_breadCrumbs,i);
		if !collision_line(x, y, breadCrumb.x, breadCrumb.y, obj_wall, false, true){
			var crumbDistance = point_distance(playerTank.x, playerTank.y, breadCrumb.x, breadCrumb.y);
			if (crumbDistance) < nearestCrumbDistance{
				nearestCrumb = breadCrumb
				nearestCrumbDistance = crumbDistance
			}
		}
	}
	if (nearestCrumb != noone) {
		// Get direction to target
		var dir = point_direction(x, y, nearestCrumb.x, nearestCrumb.y);
    
		// Calculate movement vector
		movementVector[0] = lengthdir_x(movementSpeed, dir);
		movementVector[1] = lengthdir_y(movementSpeed, dir);

	}else{
		movementVector[0] = 0;
		movementVector[1] = 0;
	}
	nearestCrumb = noone;
	nearestCrumbDistance = 99999999;
}
