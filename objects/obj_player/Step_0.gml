lol++

/*for (var i = 0; i < breadCrumbRadius*2; i++){
	for (var j = 0; j < breadCrumbRadius*2; j++){
		if (power(i - 4.5,2) + power(j - 4.5,2) <= 25){
			summonObject(obj_breadCrumbs, [["x", x-breadCrumbRadius*32+i*32], ["y", y-breadCrumbRadius*32+j*32]])
		}
	}
}*/

switch (state){
    case playerStates.normal: playerState_normal(); break;
}

//collision with walls
if (place_meeting(x + movementX(), y, obj_wall)){
	var _hStep = sign(movementX());
	stepCollisionWhileWithFailCon(obj_wall, _hStep, true)
	movementVector[0] = 0;
}
if (place_meeting(x, y + movementY(), obj_wall)){
	var _vStep = sign(movementY());
	stepCollisionWhileWithFailCon(obj_wall, _vStep, false)
	movementVector[1] = 0;
}

//attempt to make you unable to get stuck in wall
if (movementVector[0] != 0 || movementVector[1] != 0){
	var tempAngle = hitbox.image_angle;
	hitbox.image_angle = point_direction(x,y,x + movementVector[0]*movementSpeed, y + movementVector[1]*movementSpeed)
	if (place_meeting(x,y, obj_wall) && !(hitbox.image_angle = 90 || hitbox.image_angle == 180 || hitbox.image_angle == 270 || hitbox.image_angle == 0)){
		hitbox.image_angle = tempAngle;
	}
}else{
	
}

x += movementVector[0]*movementSpeed;
y += movementVector[1]*movementSpeed;


