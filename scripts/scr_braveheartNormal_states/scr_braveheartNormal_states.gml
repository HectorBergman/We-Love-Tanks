function braveheartNormal_approaching(){
	// Enemy step event
	nearestCrumb = noone;
	nearestCrumbDistance = 99999999;

	var arr = findOptimizedPath();
	if (array_length(arr) > 0) {
	    nearestCrumb = arr[0];
	    nearestCrumbDistance = arr[1];
    
	    if (nearestCrumb != noone) {
	        var dir = point_direction(x, y, nearestCrumb.x, nearestCrumb.y);
        
	        // Check if direct path to crumb is clear
	        if (!collision_line(x, y, nearestCrumb.x, nearestCrumb.y, obj_wall, false, true)) {
	            movementVector[0] = lengthdir_x(movementSpeed, dir);
	            movementVector[1] = lengthdir_y(movementSpeed, dir);
	        } else {
	            // Find alternative path around obstacles
	            findAlternativePath(dir);
	        }
        
	        // Move if path is clear
	        if (!place_meeting(x + movementVector[0], y + movementVector[1], obj_wall)) {
	            x += movementVector[0];
	            y += movementVector[1];
            
	            // Update facing direction
	            if (movementVector[0] != 0 || movementVector[1] != 0) {
	                hitbox.image_angle = point_direction(x, y, x + movementVector[0], y + movementVector[1]);
	            }
	        }
	    }
	} else {
	    // No crumbs found - patrol or use simple wall avoidance
	    state = braveheartNormal.patrolling;
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