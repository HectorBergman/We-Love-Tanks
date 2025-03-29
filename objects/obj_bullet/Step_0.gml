timeSinceBounce++
image_angle = point_direction(x,y,x+movementVector[0],y+movementVector[1]);
if (x > room_width || x < 0 || y < 0 || y > room_height){
	instance_destroy();
}
movementVector = normalizeVector(movementVector);

var xOrigin = sprite_get_xoffset(sprite_index)
var yOrigin = sprite_get_yoffset(sprite_index)
newCoords = [lengthdir_x(sprite_width - xOrigin, image_angle), 
			 lengthdir_y(sprite_height - yOrigin, image_angle)]

var hit = noone;
//instance_place(x+movementX(), y+movementY(), obj_wall)
if (place_meeting(x+movementX(), y+movementY(), obj_wall)){
	var _x = x;
	var _y = y;
	while (!place_meeting(x,y,obj_wall)){
		x += movementVector[0]*0.1;
		y += movementVector[1]*0.1;
	}if !(collision_rectangle(x+newCoords[0]-0.5,y+newCoords[1]-0.5,x+newCoords[0]+0.5,y+newCoords[1]+0.5,obj_wall,false,true)){
		x = _x
		y = _y
	}else{
		hit = instance_place(x, y, obj_wall)
	}
}

//todo: add sum shi like this for megafast bullets
var prevhit14 = instance_place(x + (prevVector[0] - x)*0.25, y, obj_wall)
var prevhit24 = instance_place(x + (prevVector[0] - x)*0.50, y, obj_wall)
var prevhit34 = instance_place(x + (prevVector[0] - x)*0.75, y, obj_wall)


/*if (place_meeting(x + movementX(), y, obj_wall)){
	var _hStep = sign(movementX());
	stepCollisionWhileWithFailCon(obj_wall, _hStep, true)
	movementVector[0] = -movementVector[0];
}
if (place_meeting(x, y + movementY(), obj_wall)){
	var _vStep = sign(movementY());
	stepCollisionWhileWithFailCon(obj_wall, _vStep, false)
	movementVector[1] = -movementVector[1];
}*/
if (hit != noone ){
	// Get the block's boundaries
	var block_left = hit.bbox_left;
	var block_right = hit.bbox_right;
	var block_top = hit.bbox_top;
	var block_bottom = hit.bbox_bottom;
	
	
	var xDifferenceLeft = x+newCoords[0] - block_left
	var xDifferenceRight = x+newCoords[0] - block_right
	var yDifferenceTop = y+newCoords[1] - block_top;
	var yDifferenceBottom = y+newCoords[1] - block_bottom;
	var smallest = min(abs(xDifferenceLeft),abs(xDifferenceRight),abs(yDifferenceTop),abs(yDifferenceBottom));
	if (smallest = abs(xDifferenceLeft)) {
		print("left");
		movementVector[0] = -movementVector[0]
		movementVector[1] = movementVector[1]
	}else if (smallest = abs(xDifferenceRight)){
		print("right");
		movementVector[0] = -movementVector[0]
		movementVector[1] = movementVector[1]
	}else if (smallest = abs(yDifferenceTop)) {
		print("top");
		movementVector[0] = movementVector[0]
		movementVector[1] = -movementVector[1]
	}else if (smallest = abs(yDifferenceBottom)){
		print("bot");
		movementVector[0] = movementVector[0]
		movementVector[1] = -movementVector[1]
	}
	/*
	var cornerLeeway = -32;

	// Threshold for collision detection (adjust as needed)
	var threshold = 5;

	// Determine which side of the block is hit
	/*
	if (abs(x- block_left) < threshold && abs(y-block_top) < threshold){
		print("lefttop");
		collisionVector[0] = 0;
	    collisionVector[1] = 0;
		var wallCoords = getWallCoords(hit, 1)
		var xDifference = fireCoords[0]-wallCoords[0]; //greater than 0 means bullet was fired "behind" wall
		var yDifference = fireCoords[1]-wallCoords[1]; //greater than 0 means bullet was fired "under" wall
		if (xDifference - cornerLeeway < 0 && yDifference + cornerLeeway < 0){ //corner
			movementVector[0] = -1*movementVector[0]
			movementVector[1] = -1*movementVector[1]
		}else if (xDifference - cornerLeeway> 0 && yDifference + cornerLeeway < 0){
			movementVector[0] = 1*movementVector[0]
			movementVector[1] = -1*movementVector[1]
		}else if (xDifference - cornerLeeway< 0 && yDifference + cornerLeeway > 0){
			movementVector[0] = -1*movementVector[0]
			movementVector[1] = 1*movementVector[1]
		}
	}
	else if (abs(x - block_left) < threshold && abs(y-block_bottom) < threshold){
		print("leftbot");
		collisionVector[0] = 0;
	    collisionVector[1] = 0;
		var wallCoords = getWallCoords(hit, 2)
		var xDifference = fireCoords[0]-wallCoords[0]; //greater than 0 means bullet was fired "behind" wall
		var yDifference = fireCoords[1]-wallCoords[1]; //greater than 0 means bullet was fired "under" wall
		if (xDifference - cornerLeeway < 0 && yDifference + cornerLeeway > 0){ //corner
			movementVector[0] = -1*movementVector[0]
			movementVector[1] = -1*movementVector[1]
		}else if (xDifference - cornerLeeway < 0 && yDifference + cornerLeeway < 0){
			movementVector[0] = -1*movementVector[0]
			movementVector[1] = 1*movementVector[1]
		}else if (xDifference - cornerLeeway > 0 && yDifference + cornerLeeway > 0){
			movementVector[0] = 1*movementVector[0]
			movementVector[1] = -1*movementVector[1]
		}
	}
	else if (abs(x- block_right) < threshold && abs(y-block_top) < threshold){
		print("righttop");
		collisionVector[0] = 0;
	    collisionVector[1] = 0;
		movementVector[0] = choose(-1, 1)*movementVector[0]
		movementVector[1] = choose(-1, 1)*movementVector[1]
	}
	else if (abs(x - block_right) < threshold && abs(y-block_bottom) < threshold){
		print("rightbot");
		collisionVector[0] = 0;
	    collisionVector[1] = 0;
		movementVector[0] = choose(-1, 1)*movementVector[0]
		movementVector[1] = choose(-1, 1)*movementVector[1]
	}
	else */

	/*
	if (determineIfWithinBoxCone(hit, 0,fireCoords,15)){
		if (abs(movementVector[0])<  
		if (yDifference < xDifference){
			
		}
		acceptable = true;
	}else if (determineIfWithinBoxCone(hit, 1,fireCoords,15)){
		var wallCoords = getWallCoords(hit, 1)
		acceptable = true;
	}else if (determineIfWithinBoxCone(hit, 2,fireCoords,15)){
		var wallCoords = getWallCoords(hit, 2)
		acceptable = true;
	}else if (determineIfWithinBoxCone(hit, 3,fireCoords,15)){
		var wallCoords = getWallCoords(hit, 3)
		acceptable = true;
	}*/
	/*
	if (!acceptable){
		if (abs(newCoords - block_left) < threshold) {
			print("left");
		    // Left edge
		    collisionVector[0] = -1;
		    collisionVector[1] = 0;
		} else if (abs(x - block_right) < threshold) {
			print("right");
		    // Right edge
		    collisionVector[0] = 1;
		    collisionVector[1] = 0;
		} else if (abs(y - block_top) < threshold) {
			print("top");
		    // Top edge
		    collisionVector[0] = 0;
		    collisionVector[1] = 1;
		} else if (abs(y - block_bottom) < threshold) {
			print("bot");
		    // Bottom edge
			collisionVector[0] = 0;
		    collisionVector[1] = -1;
		} else {
		    // Default case (no collision)
			print("heeeej");
		    collisionVector[0] = 0;
		    collisionVector[1] = 0;
			movementVector[0] = -movementVector[0]
			movementVector[1] = -movementVector[1]
		}
	}else{
		movementVector[0] = -movementVector[0]
		movementVector[1] = -movementVector[1]
	}

	// If a collision is detected, compute the new velocity
	if (collisionVector[0] != 0 || collisionVector[1] != 0) {
	    // Dot product of velocity and normal vector
	    var dotProduct =  dot_product(movementVector[0],movementVector[1],collisionVector[0],collisionVector[1]);

	    // Compute new velocity using bounce formula
	    var v_x_new = movementVector[0] - 2 * dotProduct * collisionVector[0];
	    var v_y_new = movementVector[1] - 2 * dotProduct * collisionVector[1];

	    // Update ball's velocity
	    movementVector[0] = v_x_new;
		movementVector[1] = v_y_new;
	}*/
	fireCoords = [x,y];
	
	lastWallStruck = hit;
	if (timeSinceBounce > 9){
		maxBounce--
	}
	timeSinceBounce = 0
}
//erm actually this is a prevCoord
prevVector[0] = x
prevVector[1] = y
x = x + movementX();
y = y + movementY();
	
if (maxBounce <= 0){
	parent.activeBullets = parent.activeBullets - 1
	instance_destroy();
}