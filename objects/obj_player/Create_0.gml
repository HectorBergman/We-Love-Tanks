
luck = 1;
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
hitbox = summonObject(obj_player_visual, [["parent", id], ["cannon", cannon]]);

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