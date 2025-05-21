sprite_set_offset(sprite_index, 4, spriteOffset[1]);
image_angle = angle;
draw_self();
image_angle = 0;
sprite_set_offset(sprite_index, spriteOffset[0], spriteOffset[1]);


if (keyboard_check(vk_space)){
	slowmovin++
}else{
	slowmovin = 0
}
if !(inRange(x,-32,room_width+32) && inRange(y,-32,room_height+32)){
	instance_destroy()
	exit;
}


timeSinceBounce++


newCoords = [lengthdir_x(sprite_width - sprite_xoffset, angle), 
			 lengthdir_y(sprite_height - sprite_yoffset, angle)]

var hit = 0;

// Check for wall collision  
var newAngle = collision_normal(x,y,obj_wall,3,1);
print(newAngle);
/*if (hit > 0){
	hitInARow++
		
	fireCoords = [x,y];
	
	lastWallStruck = hitWall;
	if (timeSinceBounce > 3){
		maxBounce--
	}
	timeSinceBounce = 0
}else{
	hitInARow = 0;
}*/
if newAngle != -1{
	angle = newAngle
}
print(movementVector[0]);
print(movementVector[1]);
movementVector[0] = cos(degtorad(angle))
movementVector[1] = sin(degtorad(angle));
print("----");
print(movementVector[0]);
print(movementVector[1]);
prevVector[0] = x
prevVector[1] = y
x = x + movementX();
y = y + movementY();
newCoords = [lengthdir_x(sprite_width - sprite_xoffset, angle), 
				lengthdir_y(sprite_height - sprite_yoffset, angle)]

/*if (hitInARow == 3){
	/*print(firedAngle);
	print(string(firedFrom[0]) + " " + string(firedFrom[1]));
	instance_destroy()
	
}*/
if (maxBounce <= 0){
	parent.activeBullets = parent.activeBullets - 1
	instance_destroy();
}


angle = point_direction(x,y,x+movementVector[0],y+movementVector[1]);

	prevVector[0] = x
	prevVector[1] = y
	x = x + movementX();
	y = y + movementY();
	newCoords = [lengthdir_x(sprite_width - sprite_xoffset, angle), 
					lengthdir_y(sprite_height - sprite_yoffset, angle)]

