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

//customizable probably
createCannon = true;
movementSpeed = 1;
type = stringToEnum(enemyType);
pointInMoveDir = true;
hp = 3;
print("welived");
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
if createCannon{
	cannon = summonObject(obj_enemy_cannon, [["parent", id], ["depth", depth-1]]);
}

hitbox = summonObject(obj_enemy_hitbox, [["parent", id]]);
//todo: add code for selecting a sprite according to enemy type

function death(){
	if createCannon{
		instance_destroy(cannon);
	}
	instance_destroy(hitbox);
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
