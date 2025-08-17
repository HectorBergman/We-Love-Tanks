if pause(pauseMode){print("exit");}
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
	if movementSpeed < runSpeed{
		movementSpeed += runSpeedStep
	}else{
		movementSpeed = runSpeed;
	}
}else{
	if movementSpeed > regularSpeed{
		movementSpeed -= runSpeedStep
	}else{
		movementSpeed = regularSpeed;
	}
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
if abs(inputVector[0]-movementVector[0]) < 0.05{
	movementVector[0] = inputVector[0]
}else{
	movementVector[0] += sign(inputVector[0]-movementVector[0])*movementVectorStep
}
if abs(inputVector[1]-movementVector[1]) < 0.05{
	movementVector[1] = inputVector[1]
}else{
	movementVector[1] += sign(inputVector[1]-movementVector[1])*movementVectorStep
}


if (movementVector[0] != 0 || movementVector[1] != 0){
	if wallBonkCooldown == 0{
		//hitbox.image_angle
		var goalAngle = point_direction(x,y,x + movementVector[0]*movementSpeed, y + movementVector[1]*movementSpeed)
		hitbox.image_angle = gradualPoint(goalAngle, hitbox.image_angle, turningSpeed);
		angle = hitbox.image_angle
	}else{
		wallBonkCooldown--
	}
}

player_handleWallCollision()

//attempt to make you unable to get stuck in wall


x += movementVector[0]*movementSpeed;
y += movementVector[1]*movementSpeed;




