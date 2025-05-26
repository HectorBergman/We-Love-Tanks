enum enemyPhase {
	startingUp,
	active
}

phase = enemyPhase.startingUp
startUpTimer = 90;
angle = 0;

type = stringToEnum(enemyType);
function movementX(){
	return movementVector[0]*movementSpeed;
}
function movementY(){
	return movementVector[1]*movementSpeed;
}
movementVector = [0,0];
hp = 1;
cannon = summonObject(obj_enemy_cannon, [["parent", id], ["depth", depth-1]]);
hitbox = summonObject(obj_enemy_hitbox, [["parent", id]]);
switch(type){
	case enemyTypes.stiffNormal: stiffNormal_create(); break;
	case enemyTypes.braveheartNormal: braveheartNormal_create(); break;
	case enemyTypes.stiffRicochet: stiffRicochet_create(); break; 
}
//todo: add code for selecting a sprite according to enemy type

function death(){
	instance_destroy(cannon);
	instance_destroy(hitbox);
	instance_destroy();
}

function decreaseHealth(){
	if phase != enemyPhase.startingUp{
		hp--;
	}
}
function checkForDeath(){
	if hp < 1{
		death();
	}
}
