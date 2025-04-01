

switch (state){
	case bodyEnemyStates.approaching: enemyState_approaching(); break;
}

if (place_meeting(x + movementX(), y, [obj_wall, obj_player, obj_enemy])){
	var _hStep = sign(movementX());
	stepCollisionWhileWithFailCon([obj_wall, obj_player, obj_enemy], _hStep, true)
	movementVector[0] = 0;
}
if (place_meeting(x, y + movementY(), [obj_wall, obj_player, obj_enemy])){
	var _vStep = sign(movementY());
	stepCollisionWhileWithFailCon([obj_wall, obj_player, obj_enemy], _vStep, false)
	movementVector[1] = 0;
}
if (movementVector[0] != 0 || movementVector[1] != 0){
	hitbox.image_angle = point_direction(x,y,x + movementVector[0]*movementSpeed, y + movementVector[1]*movementSpeed)
}


x += movementVector[0]
y += movementVector[1];



