function braveheartNormal_approaching(){
	timeSinceLastSquare++;
	var list = ds_list_create()
	instance_place_list(x,y,obj_gridSquare,list,true);
	var nearestSquare = ds_list_find_value(list,0)
	if nearestSquare != noone && !is_undefined(nearestSquare){
		if targetSquare == noone || targetSquare == nearestSquare || timeSinceLastSquare > timeSinceLastSquareLim{
			if targetSquare != noone{
				targetSquare.lightUp = false;
			}
			targetSquare = obj_handler_pathfinder.getNearestNeighbour2(nearestSquare);
			targetSquare.lightUp = true;
			timeSinceLastSquare = 0;
		}
		
		var dir = point_direction(x, y, targetSquare.x, targetSquare.y);
	    movementVector[0] = lengthdir_x(movementSpeed, dir);
	    movementVector[1] = lengthdir_y(movementSpeed, dir);
		
	 
	}
	
	if !collision_line(x,y,obj_player.x,obj_player.y, obj_impassable,0,1){
		state = states.spotted
	}
	var moveX = place_meeting(x + movementX(), y, [obj_impassable, obj_player, obj_enemy])
	var moveY = place_meeting(x, y + movementY(), [obj_impassable, obj_player, obj_enemy])
	ds_list_destroy(list);
	if (moveX){
		var _hStep = sign(movementX());
		stepCollisionWhileWithFailCon([obj_impassable, obj_player, obj_enemy], _hStep, true)
		if !moveY {
			movementVector[1] = sign(movementVector[1]);
		}
		movementVector[0] = 0;
	}
	if (moveY){
		var _vStep = sign(movementY());
		stepCollisionWhileWithFailCon([obj_impassable, obj_player, obj_enemy], _vStep, false)
		if !moveX {
			movementVector[0] = sign(movementVector[0]);
		}
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

	state = states.approaching
	/*if !collision_line(x,y,obj_player.x,obj_player.y, obj_wall,0,1){
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
	var width = 16;
	var collisionLines = collision_line(x,y,obj_player.x,obj_player.y, obj_impassable,0,1) || 
						 collision_line(x+width,y+width,obj_player.x+width,obj_player.y+width, obj_impassable,0,1) ||
						 collision_line(x-width,y-width,obj_player.x-width,obj_player.y-width, obj_impassable,0,1)
	if !collisionLines{
		var dir = point_direction(x, y, obj_player.x, obj_player.y);
		movementVector[0] = lengthdir_x(movementSpeed, dir);
		movementVector[1] = lengthdir_y(movementSpeed, dir);
	}else{
		state = states.approaching
		targetSquare = noone;
		timeSinceLastSquare = 0;
	}
	var moveX = place_meeting(x + movementX(), y, [obj_impassable, obj_player, obj_enemy])
	var moveY = place_meeting(x, y + movementY(), [obj_impassable, obj_player, obj_enemy])
	if (moveX){
		var _hStep = sign(movementX());
		stepCollisionWhileWithFailCon([obj_impassable, obj_player, obj_enemy], _hStep, true)
		movementVector[0] = 0;
		if !moveY {
			movementVector[1] = sign(movementVector[1]);
		}
	}
	if (moveY){
		var _vStep = sign(movementY());
		stepCollisionWhileWithFailCon([obj_impassable, obj_player, obj_enemy], _vStep, false)
		movementVector[1] = 0;
		if !moveX {
			movementVector[0] = sign(movementVector[0]);
		}
	}
}