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
summonObject(obj_player_cannon, [["parent", id], ["depth", depth-1]]);
//initialize a bunch of variables
playerVariables_movement()
generalVariables();
initializeEnums();
hitbox = summonObject(obj_player_hitbox, [["parent", id]]);

lol = 0;

breadCrumbRadius = 5;