

function findNearbyCrumbs(){
	var interval = 1;
	var halfSize = 24;
	var closestCrumb = noone
	var closestCrumbDistance = 999999
	for (var i = 0; i < instance_number(obj_breadCrumbs); ++i;){
		
		var breadCrumb = instance_find(obj_breadCrumbs,i);
		var distanceToCrumb = point_distance(x,y,breadCrumb.x,breadCrumb.y);
		var reachable = true;
		var vector = normalizedVector([x,y], [breadCrumb.x,breadCrumb.y]);
		if reachable{
			var crumbDistance = point_distance(obj_player.x, obj_player.y, breadCrumb.x, breadCrumb.y);
			if (crumbDistance) < closestCrumbDistance && !collision_line(breadCrumb.x,breadCrumb.y,obj_player.x,obj_player.y,obj_solid,0,1){ //!collision_cone(breadCrumb.x,breadCrumb.y,obj_player.x,obj_player.y,45, 5, obj_wall){
				closestCrumb = breadCrumb
				closestCrumbDistance = crumbDistance
			}
		}
	}
	return [closestCrumb, closestCrumbDistance];
}




/// @function gradualPoint(goalDirection,turningSpeed)
/// @description Gradually changes image_angle to target angle instead of snapping
/// @param {real} targetAngle Target angle, given in degrees
/// @param {real} turningSpeed Rate of turning, turningSpeed = 1 means spinning pi/2 per tick. So try to keep it below 1, preferably even below 0.1
/// @returns {bool} True if it has locked onto targetAngle, else returns false

function gradualPoint(targetAngle, turningSpeed){
	//var goalDirection = point_direction(x,y,obj_player.x, obj_player.y) mod 360;
	var turnDirection = sign(angle_difference(targetAngle, image_angle))
	
	if (abs(angle_difference(targetAngle, image_angle)) < abs(radtodeg(turningSpeed*pi/2))*2){
		return true; 
	}else{
		image_angle = (image_angle + radtodeg(turnDirection*pi/2*turningSpeed))
		return false;
	}
	
	
}

/// @function gradualPointOverTime(goalDirection,turningSpeed)
/// @description Returns the angle needed every step to go from current image_angle to target angle.
/// @param {real} targetAngle Target angle, given in degrees
/// @param {real} steps Amount of steps to reach target angle
/// @returns {real} The angle to be added over (steps) steps

function gradualPointOverTime(targetAngle, steps){
	var turnDirection = sign(angle_difference(targetAngle, image_angle))
	return angle_difference(targetAngle, image_angle)/steps; 
}