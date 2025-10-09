pauseMode = allPause;
enum bossPhase {
	startingUp,
	active
}
enum bossTypes {
	testStar,
}
depth = -100
color = c_white;
phase = bossPhase.startingUp
startUpTimer = 90;
hit = -99;
collideable = true;
valueRange = [110,130];

//customizable probably
createCannon = true;
movementSpeed = 1;
type = stringToEnum(bossType);
pointInMoveDir = true;
hp = 100;
function movementX(){
	return movementVector[0]*movementSpeed;
}
function movementY(){
	return movementVector[1]*movementSpeed;
}
movementVector = [0,0];


switch(type){
	case bossTypes.testStar : testStar_create(); break;
	//case enemyTypes.stiffNormal: stiffNormal_create(); break;
}


hitbox = summonObject(obj_boss_hitbox, [["parent", id]]);
//todo: add code for selecting a sprite according to boss type

function death(){
	dropMoney(valueRange);
	with hitbox{
		id.death();
	}
	var dinfo = getDeceasedInfo(id)
	SignalSend("onKill",dinfo)
	//obj_currentRoomHandler._room.bossBeaten = true;
	if (instance_number(obj_enemy) <= 1 && instance_number(obj_boss) <= 1){
		SignalSend("clearedStatus", true)
	}
	SignalSend("Boss defeated") //todo: account for more than 1 boss being present
	instance_destroy();
}

function decreaseHealth(amount){
	if phase != bossPhase.startingUp{
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

