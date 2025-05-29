function stiffBuckshot_create(){
	//todo: sprites

	state = stiffBuckshot.normal

	distance = point_distance(x, y, playerTank.x, playerTank.y);
	distanceX = abs(playerTank.x - x);
	distanceY = abs(playerTank.y - y);
	hp = 3;
	playerSeen = false;
	wallSeen = 0;

	detectionSquareWidth = 6;

}

function stiffBuckshot_step(){
	distance = point_distance(x, y, playerTank.x, playerTank.y);
	distanceX = abs(playerTank.x - x);
	distanceY = abs(playerTank.y - y);
	switch (state){
		case stiffNormal.normal: stiffNormal_normal(); break;
	}
	wallSeen = 0;

}