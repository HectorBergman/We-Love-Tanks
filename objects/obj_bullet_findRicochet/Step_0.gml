timeSinceBounce++
image_angle = point_direction(x,y,x+movementVector[0],y+movementVector[1]);
if (x > room_width || x < 0 || y < 0 || y > room_height){
	instance_destroy();
}
movementVector = normalizeVector(movementVector);


newCoords = [lengthdir_x(sprite_width - sprite_xoffset, image_angle), 
			 lengthdir_y(sprite_height - sprite_yoffset, image_angle)]
while !place_meeting(x+movementX(), y+movementY(), obj_wall){
	if originalAngle == 150{
		print("x: " + string(x));
		print("y: " + string(y));
	}
	var distance = point_distance(x+newCoords[0],y+newCoords[1], playerTank.x,playerTank.y)
	closestDistanceToPlayer = min(closestDistanceToPlayer,distance);
	x += movementX();
	y += movementY();
}

var hit = noone;

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
		latestWallHit = 2;
		//print("left");
		movementVector[0] = -movementVector[0]
		movementVector[1] = movementVector[1]
	}else if (smallest = abs(xDifferenceRight)){
		latestWallHit = 0;
		//print("right");
		movementVector[0] = -movementVector[0]
		movementVector[1] = movementVector[1]
	}else if (smallest = abs(yDifferenceTop)) {
		latestWallHit = 1;
		//print("top");
		movementVector[0] = movementVector[0]
		movementVector[1] = -movementVector[1]
	}else if (smallest = abs(yDifferenceBottom)){
		latestWallHit = 3;
		//print("bot");
		movementVector[0] = movementVector[0]
		movementVector[1] = -movementVector[1]
	}
	fireCoords = [x,y];
	
	lastWallStruck = hit;
	if (timeSinceBounce < 9){
		maxBounce--
	}
	timeSinceBounce = 0
}
image_angle = point_direction(x,y,x+movementVector[0],y+movementVector[1]);
//erm actually this is a prevCoord

prevVector[0] = x
prevVector[1] = y
x = x + movementX();
y = y + movementY();
newCoords = [lengthdir_x(sprite_width - sprite_xoffset, image_angle), 
				 lengthdir_y(sprite_height - sprite_yoffset, image_angle)]
if (collision_rectangle(x+newCoords[0]-0.5, y+newCoords[1]-0.5,x+newCoords[0]+0.5, y+newCoords[1]+0.5,obj_wall,true,true)){
	x = prevVector[0];
	y = prevVector[1];
	if (latestWallHit == 0){
		movementVector[1] = -movementVector[1]
	}else if (latestWallHit == 1){
		movementVector[0] = -movementVector[0]
	}else if (latestWallHit == 2){
		movementVector[1] = -movementVector[1]
	}else if (latestWallHit == 3){
		movementVector[0] = -movementVector[0]
	}
	x = x + movementX();
	y = y + movementY();
}

if (maxBounce <= 0){
	print("-------------");
	print(closestDistanceToPlayer);
	print(originalAngle);
	ricochetArray[originalAngle] = closestDistanceToPlayer
	instance_destroy();
}