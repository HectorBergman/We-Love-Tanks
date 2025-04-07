function enemyState_approaching(){
	var arr = findNearbyCrumbs()
	nearestCrumb = arr[0];
	nearestCrumbDistance = arr[1];
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

}


function findNearbyCrumbs(){
	var interval = 1;
	var halfSize = 24;
	var closestCrumb = noone
	var closestCrumbDistance = 999999
	for (var i = 0; i < instance_number(obj_breadCrumbs); ++i;){
		
		var breadCrumb = instance_find(obj_breadCrumbs,i);
		var distanceToCrumb = point_distance(x,y,breadCrumb.x,breadCrumb.y);
		var reachable = true;
		var vector = normalizedVector(id, breadCrumb);
		for (var j = 16; j < distanceToCrumb; j = j+interval){
			if collision_rectangle(x+vector[0]*j-halfSize, y+vector[1]*j-halfSize, x+vector[0]*(j+interval)+halfSize, y+vector[1]*(j+interval)+halfSize, obj_wall, 0, 1){
				reachable = false;
				break;
			}
		}
		if reachable{
			var crumbDistance = point_distance(playerTank.x, playerTank.y, breadCrumb.x, breadCrumb.y);
			if (crumbDistance) < closestCrumbDistance && !collision_line(breadCrumb.x,breadCrumb.y,playerTank.x,playerTank.y,[obj_wall, obj_enemy],0,1){ //!collision_cone(breadCrumb.x,breadCrumb.y,playerTank.x,playerTank.y,45, 5, obj_wall){
				closestCrumb = breadCrumb
				closestCrumbDistance = crumbDistance
			}
		}
	}
	return [closestCrumb, closestCrumbDistance];
}