PAUSE

if !obj_handler_input.heldSpace{
	debugTimer--
}
if debugTimer == 0 || !debug.isOn{
	setTopMidBot()
	var collisionAngle = collision_normal(x+movementX(),y+movementY(),obj_solid,2,1)
	findBounce();
	ricochetBounce();
	image_angle = point_direction(x,y,x+movementVector[0],y+movementVector[1]);
	x = x+movementVector[0]
	y = y+movementVector[1]
	debugTimer = debugTime;
}

