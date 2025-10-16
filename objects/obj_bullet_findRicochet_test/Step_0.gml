PAUSE

if !obj_inputHandler.heldSpace{
	debugTimer--
}
if debugTimer == 0{
	setTopMidBot()
	var collisionAngle = collision_normal(x+movementX(),y+movementY(),obj_solid,2,1)
	findBounce();
	ricochetBounce();
	image_angle = point_direction(x,y,x+movementVector[0],y+movementVector[1]);
	x = x+movementVector[0]*6
	y = y+movementVector[1]*6
	debugTimer = debugTime;
	
}

/*while collisionAngle == -1{
	collisionAngle = collision_normal(x+movementX(),y+movementY(),obj_solid,2,1)
	if !(inRange(x,-32,room_width+32) && inRange(y,-32,room_height+32)){
		
		instance_destroy()
		exit;
	}
	if !(collision_line(x,y,obj_player.x,obj_player.y, obj_solid, 0,0)){
		var distance = point_distance(x+newCoords[0],y+newCoords[1], obj_player.x,obj_player.y)
		closestDistanceToPlayer = min(closestDistanceToPlayer,distance);
	}
	if collisionAngle != -1{
		var dot = movementVector[0] * cos(degtorad(collisionAngle)) + movementVector[1] * sin(degtorad(collisionAngle));
		reflectedVector[0] = movementVector[0] - 2 * dot * cos(degtorad(collisionAngle));
		reflectedVector[1] = movementVector[1] - 2 * dot * sin(degtorad(collisionAngle));
		movementVector[0] = reflectedVector[0]
		movementVector[1] = reflectedVector[1]
	}
	x += movementX();
	y += movementY();
	
}
ricochetBounce();

image_angle = point_direction(x,y,x+movementVector[0],y+movementVector[1]);

prevVector[0] = x
prevVector[1] = y

