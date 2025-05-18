function stiffRicochet_create(){
	_health = 1;
	state = stiffRicochet.normal;

	distance = point_distance(x, y, playerTank.x, playerTank.y);
	distanceX = abs(playerTank.x - x);
	distanceY = abs(playerTank.y - y);//this might be pointless

	playerSeen = false;
	wallSeen = 0;

	detectionSquareWidth = 6;
}

function stiffRicochet_step(){
	distance = point_distance(x, y, playerTank.x, playerTank.y);
	distanceX = abs(playerTank.x - x);
	distanceY = abs(playerTank.y - y);//this might be pointless
}
