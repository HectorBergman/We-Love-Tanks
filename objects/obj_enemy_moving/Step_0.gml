

switch (state){
    case bodyEnemyStates.normal: enemyState_normal(); break;
	case bodyEnemyStates.prowling: enemyState_prowling(); break;
}

/*if (place_meeting(x + movementX(), y, obj_wall)){
	var _hStep = sign(movementX());
	stepCollisionWhileWithFailCon(obj_wall, _hStep, true)
	movementVector[0] = 0;
}
if (place_meeting(x, y + movementY(), obj_wall)){
	var _vStep = sign(movementY());
	stepCollisionWhileWithFailCon(obj_wall, _vStep, false)
	movementVector[1] = 0;
}
if (movementVector[0] != 0 || movementVector[1] != 0){
	show_debug_message(lol);
	var tempAngle = image_angle;
	image_angle = point_direction(x,y,x + movementVector[0]*movementSpeed, y + movementVector[1]*movementSpeed)
	if (place_meeting(x,y, obj_wall) && !(image_angle = 90 || image_angle == 180 || image_angle == 270 || image_angle == 0)){
		image_angle = tempAngle;
	}
}
x += movementVector[0]*movementSpeed;
y += movementVector[1]*movementSpeed;*/


