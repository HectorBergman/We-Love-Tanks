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
	var collisionArr = collision_normal(x,y,obj_wall,9,1)
	var collisionAngle = collisionArr[0]
	print(ds_map_find_value(hitMap,collisionArr[1]));
	if collisionAngle != -1 && is_undefined(ds_map_find_value(hitMap,collisionArr[1])){
		var dot = movementVector[0] * cos(degtorad(collisionAngle)) + movementVector[1] * sin(degtorad(collisionAngle));
		reflectedVector[0] = movementVector[0] - 2 * dot * cos(degtorad(collisionAngle));
		reflectedVector[1] = movementVector[1] - 2 * dot * sin(degtorad(collisionAngle));
		movementVector[0] = reflectedVector[0]
		movementVector[1] = reflectedVector[1]
		
		ds_map_add(hitMap,collisionArr[1],0)
		print(movementVector[0])
		print(movementVector[1]);
		print(degtorad(collisionAngle));
	}
	
	image_angle = point_direction(x,y,x+movementVector[0],y+movementVector[1]);

	prevVector[0] = x
	prevVector[1] = y
	x = x + movementX();
	y = y + movementY();

	
}

function ageHitMap(){
	var currentKey = ds_map_find_first(hitMap);

	// Loop until we run out of keys
	while (!is_undefined(currentKey)) {
	    // Access the value using the current key
	    var currentValue = hitMap[? currentKey];
    
	    // Do something with the key-value pair
		currentValue[1]++
		if currentValue[1] > 5{
			ds_map_delete(hitMap, currentKey);
		}
    
	    // Move to the next key
	    currentKey = ds_map_find_next(hitMap, currentKey);
	}
}
