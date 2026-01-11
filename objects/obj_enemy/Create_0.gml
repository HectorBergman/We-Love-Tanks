pauseMode = allPause;
enum enemyPhase {
	startingUp,
	active
}
color = c_white;
phase = enemyPhase.startingUp
startUpTimer = 90;
angle = 0;
hit = -99;
collideable = true;
valueRange = [1.5,3];

//customizable probably
createCannon = true;
movementSpeed = 1;
type = enemyType;
pointInMoveDir = true;
hp = 3;
function movementX(){
	return movementVector[0]*movementSpeed*ts;
}
function movementY(){
	return movementVector[1]*movementSpeed*ts;
}
movementVector = [0,0];

exeStateFunc("create_", type);

cannon = noone;
if createCannon{
	cannon = summonObject(obj_enemy_cannon, [["parent", id], ["depth", depth-1]]);
}
hitbox = summonObject(obj_enemy_hitbox, [["parent", id]]);
//todo: add code for selecting a sprite according to enemy type

function death(){
	dropMoney(valueRange);
	if createCannon{
		with cannon{
			id.death();
		}
	}
	with hitbox{
		id.death();
	}
	var onKill_info = getInfo_onKill()
	SignalSend("onKill",onKill_info)
	if (instance_number(obj_enemy) <= 1 && instance_number(obj_boss) <= 1){
		SignalSend("clearedStatus", true)
	}
	instance_destroy();
}

function decreaseHealth(amount){
	if amount == 0{
		return;
	}
	if phase != enemyPhase.startingUp{
		hp -= amount;
	}
	color = c_red;
	hit = 20;
}

function checkForDeath(){
	
	if hp < 1{
		death();
	}
}