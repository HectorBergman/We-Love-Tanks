PAUSE

if keyboard_check(ord("J")) || keyboard_check_pressed(ord("K")){
	summonObject(obj_levelTransition, [["x", x], ["y", y]]);
}
if keyboard_check_pressed(ord("P")){
	global.pause = true;
}

checkForDeath();
loop_onTick();
pickupMoney();
if keyboard_check(vk_tab){
	gothruwalls = true;
}else{
	gothruwalls = false;
}
if invincible{
	invincibilityFrames--
}
if invincibilityFrames == 0{
	invincibilityFrames = 60;
	invincible = false;
}
lol++
if obj_inputHandler.run{
	movementSpeed = runSpeed
}else{
	movementSpeed = regularSpeed;
}

if keyboard_check_pressed(ord("M")){
	summonObject(obj_dollar, [["x", x], ["y", y], 
			["dir", random_range(0,360)], ["velocity", random_range(0.1,1.5)],
			["zSpeed", random_range(-4,-8)],["value", 100]]);
}
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
var moveX = instance_place(x + movementX(), y, [obj_impassable, obj_enemy])
var moveY = instance_place(x, y + movementY(), [obj_impassable, obj_enemy])
//collision with walls
if (moveX != noone && moveX.collideable && !gothruwalls){
	var _hStep = sign(movementX());
	stepCollisionWhileWithFailCon([obj_impassable, obj_enemy], _hStep, true)
	movementVector[0] = 0;
}
if (moveY != noone && moveY.collideable && !gothruwalls){
	var _vStep = sign(movementY());
	stepCollisionWhileWithFailCon([obj_impassable, obj_enemy], _vStep, false)
	movementVector[1] = 0;
}

//attempt to make you unable to get stuck in wall
if (movementVector[0] != 0 || movementVector[1] != 0){
	var tempAngle = hitbox.image_angle;
	hitbox.image_angle = point_direction(x,y,x + movementVector[0]*movementSpeed, y + movementVector[1]*movementSpeed)
	angle = point_direction(x,y,x + movementVector[0]*movementSpeed, y + movementVector[1]*movementSpeed)
	if (place_meeting(x,y, obj_impassable) && !(hitbox.image_angle == 90 || hitbox.image_angle == 180 || hitbox.image_angle == 270 || hitbox.image_angle == 0)){
		hitbox.image_angle = tempAngle;
	}
}else{
	
}

x += movementVector[0]*movementSpeed;
y += movementVector[1]*movementSpeed;


