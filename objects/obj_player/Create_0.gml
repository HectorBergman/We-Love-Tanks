

enum playerStates{
	normal,
}
state = playerStates.normal;
function movementX(){
	return movementVector[0]*movementSpeed;
}
function movementY(){
	return movementVector[1]*movementSpeed;
}
resetInputs() //same effect as initializing inputs
cannon = summonObject(obj_player_cannon, [["parent", id], ["depth", depth-1]]);
hitbox = summonObject(obj_player_hitbox, [["parent", id]]);

//initialize a bunch of variables
playerVariables_movement()
generalVariables();
initializeEnums();
hp = 3;

lol = 0;

breadCrumbRadius = 5;

function death(){
	cannon.visible = false;
	hitbox.visible = false;
	visible = false;
}

function decreaseHealth(){
	loop_onHit();
	hp--;
}
function checkForDeath(){
	if hp < 1{
		death();
	}
}