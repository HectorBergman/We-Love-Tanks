pauseMode = [pM.pauseMenu, pM.transition, pM.shop]
luck = 1;

wallBonkCooldownTime = 10;
wallBonkCooldown = 0;
movementVectorStep = 0.08;
runSpeedStep = 0.4;
turningSpeed = 99;
enum playerStates{
	normal,
}
state = playerStates.normal;
inputVector = [0,0];
function movementX(){
	return movementVector[0]*movementSpeed;
}
function movementY(){
	return movementVector[1]*movementSpeed;
}
gothruwalls = false;
activeBullets = [];

function summonEssentials(){
	cannon = summonObject(obj_player_cannon, [["parent", id], ["depth", depth-1]]);
	hitbox = summonObject(obj_player_visual, [["parent", id], ["cannon", cannon]]);
	crosshair = summonObject(obj_crosshair);
	itemHandler = summonObject(obj_itemHandler);
}
summonEssentials();

//initialize a bunch of variables
playerVariables_movement()
generalVariables();
initializeEnums();
hp = 99;

invincibilityFrames = 90;
invincible = false;

backJackList = ds_list_create();
angle = 0;
lol = 0;

breadCrumbRadius = 5;

function death(){
	cannon.visible = false;
	hitbox.visible = false;
	visible = false;
}

function decreaseHealth(amount){
	if !invincible{
		invincible = true;
		loop_onHit();
		hp -= amount;
	}
}
function checkForDeath(){
	if hp < 1{
		death();
	}
}

function player_handleWallCollision(){
	var moveX = instance_place(x + movementX(), y, [obj_impassable, obj_enemy])
	var moveY = instance_place(x, y + movementY(), [obj_impassable, obj_enemy])
	if (moveX != noone && moveX.collideable && !gothruwalls){
		var _hStep = sign(movementX());
		stepCollisionWhileWithFailCon([obj_impassable, obj_enemy], _hStep, true)
		if abs(movementVector[0]) > 0.4{
			movementVector[0] = -movementVector[0]*0.5;
			wallBonkCooldown = wallBonkCooldownTime;
		}else{
			movementVector[0] = 0;
		}
		
	}
	if (moveY != noone && moveY.collideable && !gothruwalls){
		var _vStep = sign(movementY());
		stepCollisionWhileWithFailCon([obj_impassable, obj_enemy], _vStep, false)
		if abs(movementVector[1]) > 0.4{
			movementVector[1] = -movementVector[1]*0.5;
			wallBonkCooldown = wallBonkCooldownTime;
		}else{
			movementVector[1] = 0;
		}
		wallBonkCooldown = wallBonkCooldownTime;
	}
}



