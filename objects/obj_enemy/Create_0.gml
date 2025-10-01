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
type = stringToEnum(enemyType);
pointInMoveDir = true;
hp = 3;
function movementX(){
	return movementVector[0]*movementSpeed;
}
function movementY(){
	return movementVector[1]*movementSpeed;
}
movementVector = [0,0];


switch(type){
	case enemyTypes.stiffNormal: stiffNormal_create(); break;
	case enemyTypes.braveheartNormal: braveheartNormal_create(); break;
	case enemyTypes.stiffRicochet: stiffRicochet_create(); break; 
	case enemyTypes.stiffBuckshot: stiffBuckshot_create(); break; 
	case enemyTypes.tinyman: tinyman_create(); break;
}
cannon = noone;
if createCannon{
	cannon = summonObject(obj_enemy_cannon, [["parent", id], ["depth", depth-1]]);
}
print(hp);
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
	var dinfo = getDeceasedInfo(id)
	with obj_player{
		loop_onKill(dinfo)
	}
	SignalSend("clearedStatus", true)
	instance_destroy();
}

function decreaseHealth(amount){
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