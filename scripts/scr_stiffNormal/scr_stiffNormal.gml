function stiffNormal_create(){
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

function stiffNormal_step(){
	distance = point_distance(x, y, obj_player.x, obj_player.y);
	distanceX = abs(obj_player.x - x);
	distanceY = abs(obj_player.y - y);
	exeStateFunc("stiffNormal_", state);
	wallSeen = 0;

}