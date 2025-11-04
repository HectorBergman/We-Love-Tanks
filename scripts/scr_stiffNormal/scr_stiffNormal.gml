function create_stiffNormal(){
	//todo: sprites
	states = createStates("normal");
	state = states.normal

	distance = point_distance(x, y, obj_player.x, obj_player.y);
	distanceX = abs(obj_player.x - x);
	distanceY = abs(obj_player.y - y);
	hp = 4;
	playerSeen = false;
	wallSeen = 0;
	
	detectionSquareWidth = 6;

}

function step_stiffNormal(){
	distance = point_distance(x, y, obj_player.x, obj_player.y);
	distanceX = abs(obj_player.x - x);
	distanceY = abs(obj_player.y - y);
	exeStateFunc("stiffNormal_", state);
	wallSeen = 0;

}