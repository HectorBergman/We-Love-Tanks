
PAUSE

if keyboard_check(ord("J")) || keyboard_check_pressed(ord("K")){
	//with obj_levelHandler{enterLevel();} (TOO FAST!)
	global.disablePrints = true;
	summonObject(obj_lvlTrans_debug, [["x", x], ["y", y]]);
}else{
	global.disablePrints = false;
}
if keyboard_check_pressed(ord("P")){
	global.pause = true;
}

checkForDeath();
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

playerMovement_state()
movementVector = calculateVector(movementVector, trueMovementVector, inputVector, 0.05)

player_handleWallCollision()


x += horizontalMoveSpeed*ts;
y += verticalMoveSpeed*ts;

if keyboard_check_pressed(ord("M")){
	summonObject(obj_dollar, [["x", x], ["y", y], 
			["dir", random_range(0,360)], ["velocity", random_range(0.1,1.5)],
			["zSpeed", random_range(-4,-8)],["value", 100]]);
}

if listenForInput("space"){
	summonObject(obj_bomb,
		[["x",x],["y",y],
			["radius",64],["lifespan",180]])
}

SignalSend("onTick", {id : id});


