function stiffNormal_create(){
	//todo: sprites
	_health = 1;
	state = stiffNormal.normal

	distance = point_distance(x, y, playerTank.x, playerTank.y);
	distanceX = abs(playerTank.x - x);
	distanceY = abs(playerTank.y - y);

	playerSeen = false;
	wallSeen = 0;

	detectionSquareWidth = 6;

}

function stiffNormal_step(){
	distance = point_distance(x, y, playerTank.x, playerTank.y);
	distanceX = abs(playerTank.x - x);
	distanceY = abs(playerTank.y - y);
	switch (state){
		case stiffNormal.normal: stiffNormal_normal(); break;
	}
	wallSeen = 0;

}