function braveheartNormal_approaching(){

	var list = ds_list_create()
	instance_place_list(x,y,obj_gridSquare,list,true);
	var nearestSquare = ds_list_find_value(list,0)
	if nearestSquare != noone && !is_undefined(nearestSquare){
		if targetSquare == noone || targetSquare == nearestSquare{
			targetSquare = pfHandler.getNearestNeighbour2(nearestSquare);
		}
		
		var dir = point_direction(x, y, targetSquare.x, targetSquare.y);
	    movementVector[0] = lengthdir_x(movementSpeed, dir);
	    movementVector[1] = lengthdir_y(movementSpeed, dir);
		
	 
	}
	
	if !collision_line(x,y,playerTank.x,playerTank.y, obj_wall,0,1){
		state = braveheartNormal.spotted
	}
	ds_list_destroy(list);
	if (place_meeting(x + movementX(), y, [obj_wall, obj_player])){
		var _hStep = sign(movementX());
		stepCollisionWhileWithFailCon([obj_wall, obj_player], _hStep, true)
		movementVector[0] = 0;
	}
	if (place_meeting(x, y + movementY(), [obj_wall, obj_player])){
		var _vStep = sign(movementY());
		stepCollisionWhileWithFailCon([obj_wall, obj_player], _vStep, false)
		movementVector[1] = 0;
	}
	/*var arr = findOptimizedPath();
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
	           
            
	            // Update facing direction
	            if (movementVector[0] != 0 || movementVector[1] != 0) {
	                hitbox.image_angle = point_direction(x, y, x + movementVector[0], y + movementVector[1]);
	            }
	        }
	    }
	} else {
	    // No crumbs found - patrol or use simple wall avoidance
	    state = braveheartNormal.patrolling;
	}*/
	
	
	

}

function braveheartNormal_patrolling(){

	state = braveheartNormal.approaching
	/*if !collision_line(x,y,playerTank.x,playerTank.y, obj_wall,0,1){
		var arr = findNearbyCrumbs()
		nearestCrumb = arr[0];
		if (nearestCrumb == noone){
			
		}else{
			state = braveheartNormal.approaching
		}
	}else{
		state = braveheartNormal.spotted
	}*/
	
}

function braveheartNormal_spotted(){

	if !collision_line(x,y,playerTank.x,playerTank.y, obj_wall,0,1){
		var dir = point_direction(x, y, playerTank.x, playerTank.y);
		movementVector[0] = lengthdir_x(movementSpeed, dir);
		movementVector[1] = lengthdir_y(movementSpeed, dir);
	}else{
		state = braveheartNormal.approaching
	}
	if (place_meeting(x + movementX(), y, [obj_wall, obj_player])){
		var _hStep = sign(movementX());
		stepCollisionWhileWithFailCon([obj_wall, obj_player], _hStep, true)
		movementVector[0] = 0;
	}
	if (place_meeting(x, y + movementY(), [obj_wall, obj_player])){
		var _vStep = sign(movementY());
		stepCollisionWhileWithFailCon([obj_wall, obj_player], _vStep, false)
		movementVector[1] = 0;
	}
}