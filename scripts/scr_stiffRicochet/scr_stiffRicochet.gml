function create_stiffRicochet(){
	valueRange = [4,6];
	_health = 1;
	state = stiffRicochet.normal;

	distance = point_distance(x, y, obj_player.x, obj_player.y);
	distanceX = abs(obj_player.x - x);
	distanceY = abs(obj_player.y - y);//this might be pointless

	playerSeen = false;
	wallSeen = 0;

	detectionSquareWidth = 6;
}

function step_stiffRicochet(){
	distance = point_distance(x, y, obj_player.x, obj_player.y);
	distanceX = abs(obj_player.x - x);
	distanceY = abs(obj_player.y - y);//this might be pointless
}
