function stiffNormal_create(){
	//todo: sprites

	state = stiffNormal.normal

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
	switch (state){
		case stiffNormal.normal: stiffNormal_normal(); break;
	}
	wallSeen = 0;

}