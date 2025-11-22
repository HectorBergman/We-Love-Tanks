pauseMode = [pM.pauseMenu, pM.transition, pM.dead]
luck = 1;
//SignalSubscribe(id,"roomEntered: newRoom",function(){x = room_width/2; y = room_height/2;})
global.deadPause = false;

wallBonkCooldownTime = 10;
wallBonkCooldown = 0;
movementVectorStep = 0.08;
runSpeedStep = 0.4;
turningSpeed = 99;

enum playerStates{
	normal,
}
enum movementStates{
	walk,
	run,
	nothing,
}
enum turnStates{
	normal,
	turn
}

movementState = movementStates.nothing;
state = playerStates.normal;
turnState = turnStates.normal;
inputVector = [0,0];
trueMovementVector = [0,0];

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
	//?
}
summonEssentials();
fakeMovementVec = [0,0]
//initialize a bunch of variables
playerVariables_movement()
generalVariables();
initializeEnums();
maxHp = 10
hp = 1;
displayMax = 20;


invincibilityFrames = 90;
invincible = false;

backJackList = ds_list_create();
angle = 0;

breadCrumbRadius = 5;

subToTriggers(object_index)

function death(){
	cannon.visible = false;
	hitbox.visible = false;
	visible = false;
	global.deadPause = true;
	SignalSend("changeIngameState", ingameStates.dead);
}

function decreaseHealth(amount){
	print("take damage: ",amount);
	if !invincible{
		invincible = true;
		SignalSend("onHit", {cannonId: cannon, bulletInfo: cannon.bulletInfo});
		hp -= amount;
	}
}
function checkForDeath(){
	if hp < 1{
		death();
	}
}

enum collide_type{
	hard,
	soft,
	none,//always last!!!
}
function player_handleWallCollision(){
	print("handlerwallcoll")
	var collideTypes_list = [[obj_wall, obj_wall_breakable, obj_enemy], [obj_wall_breakable_bits]]
	var collideTypes_list_full = [obj_impassable, obj_enemy, obj_frail]
	var moveX_list = ds_list_create()
	instance_place_list(x + movementX(), y, collideTypes_list_full, moveX_list, false)
	var lenX = ds_list_size(moveX_list)
	
	
	for (var i = 0; i < lenX; i++){
		var moveX = ds_list_find_value(moveX_list,0)
		var type = collideType_find(moveX, collideTypes_list);
		if player_collision(type, moveX, collideTypes_list, false){break}
	}
	var moveY_list = ds_list_create()
	instance_place_list(x, y + movementY(), collideTypes_list_full, moveY_list, false)
	var lenY = ds_list_size(moveY_list)
	
	for (var i = 0; i < lenY; i++){
		var moveY = ds_list_find_value(moveY_list,0)
		var type = collideType_find(moveY, collideTypes_list);
		if player_collision(type, moveY, collideTypes_list, true){break}
	}
	ds_list_destroy(moveX_list)
	ds_list_destroy(moveY_list)
	
}

function collideType_find(instance, list){
	var type = collide_type.none
	if array_contains(list[0], instance.object_index){
		type = collide_type.hard
	}else if array_contains(list[1], instance.object_index){
		type = collide_type.soft
	}
	return type;
}

function player_collision(type, collision_instance, collideTypes_list, isYMovement){
	switch (type){
		case collide_type.none: return false;
			
		case collide_type.hard:{
			print("swag");
			if (collision_instance.collideable && !gothruwalls){
				var _step = sign(movementX()*!isYMovement + movementY()*isYMovement);
				stepCollisionWhileWithFailCon(collideTypes_list[type], _step, true)
				if abs(movementSpeed) > 0.5{
					movementSpeed = movementSpeed*-0.7
					wallBonkCooldown = wallBonkCooldownTime;
				}else{
					movementSpeed = 0
				}
			}
		}break;
		
		case collide_type.soft:{
			if (collision_instance.collideable && !gothruwalls){
				instance_destroy(collision_instance)
				movementSpeed -= 0.1
			}
		}break;
	}
	return true
}
//because otherwise doors dont work on game start, probably delete later
SignalSend("transitionEnd")

