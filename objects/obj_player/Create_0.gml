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

movementState_x = movementStates.nothing;
movementState_y = movementStates.nothing;
rot_vel = 0;
state = playerStates.normal;
turnState = turnStates.normal;
horizontalMoveSpeed = 0;
verticalMoveSpeed = 0;
inputVector = [0,0];
trueMovementVector = [0,0];


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
timeSpentTurning = -3
angDiff = 0;
//initialize a bunch of variables
playerVariables_movement()
generalVariables();
initializeEnums();
maxHp = 10
hp = 1;
displayMax = 20;

invincibilityFrames = 90;
invincible = false;


angle = 0;

breadCrumbRadius = 5;

subToTriggers(object_index)

SignalSubscribe(id, "playerMoved", function(){
	var list = ds_list_create()
	instance_place_list(x,y,obj_wall_breakable,list,false)
	var len = ds_list_size(list)

	for (var i = 0; i < len; i++){
		print("penis");
		var val = ds_list_find_value(list,i)
		with val{
			sunder()
		}
	}
	ds_list_destroy(list);
})	

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

//because otherwise doors dont work on game start, probably delete later
SignalSend("transitionEnd")

