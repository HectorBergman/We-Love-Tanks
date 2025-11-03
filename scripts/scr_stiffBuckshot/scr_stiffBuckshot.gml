function create_stiffBuckshot(){
	//todo: sprites
	states = createStates("normal");
	state = states.normal;

	distance = point_distance(x, y, obj_player.x, obj_player.y);
	distanceX = abs(obj_player.x - x);
	distanceY = abs(obj_player.y - y);
	hp = 3;
	playerSeen = false;
	wallSeen = 0;

	detectionSquareWidth = 6;

}

function step_stiffBuckshot(){
	distance = point_distance(x, y, obj_player.x, obj_player.y);
	distanceX = abs(obj_player.x - x);
	distanceY = abs(obj_player.y - y);
	exeStateFunc("stiffBuckshot_", state)
	wallSeen = 0;

}