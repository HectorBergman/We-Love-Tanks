if (keyboard_check(vk_space)){
	slowmovin++
}else{
	slowmovin = 0
}
if !(inRange(x,-32,room_width+32) && inRange(y,-32,room_height+32)){
	instance_destroy()
}
if (slowmovin mod 60 == 0){
	timeSinceBounce++
	image_angle = point_direction(x,y,x+movementVector[0],y+movementVector[1]);
	//if (x > room_width || x < 0 || y < 0 || y > room_height){
		//instance_destroy();
	//}
	movementVector = normalizeVector(movementVector);


	newCoords = [lengthdir_x(sprite_width - sprite_xoffset, image_angle), 
					lengthdir_y(sprite_height - sprite_yoffset, image_angle)]

	var hit = 0;

	if (place_meeting(x+movementX(), y+movementY(), obj_wall)){

		
		while (!place_meeting(x,y,obj_wall)){
			x += movementVector[0]*0.1;
			y += movementVector[1]*0.1;
		}
		hit = instance_place_list(x, y, obj_wall, hitList, 1)

	}



	var hitWall = ds_list_find_value(hitList,0);
	
    
	
	if (hit > 0){
		hitInARow++
		
		fireCoords = [x,y];
	
		lastWallStruck = hitWall;
		if (timeSinceBounce > 3){
			maxBounce--
		}
		timeSinceBounce = 0
	}else{
		hitInARow = 0;
	}
	image_angle = point_direction(x,y,x+movementVector[0],y+movementVector[1]);

	prevVector[0] = x
	prevVector[1] = y
	x = x + movementX();
	y = y + movementY();
	newCoords = [lengthdir_x(sprite_width - sprite_xoffset, image_angle), 
					lengthdir_y(sprite_height - sprite_yoffset, image_angle)]

	if (hitInARow == 3){
		/*print(firedAngle);
		print(string(firedFrom[0]) + " " + string(firedFrom[1]));*/
		instance_destroy()
	
	}
	if (maxBounce <= 0){
		parent.activeBullets = parent.activeBullets - 1
		instance_destroy();
	}

	ds_list_clear(hitList);
}
