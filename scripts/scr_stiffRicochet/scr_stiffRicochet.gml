function stiffRicochet_create(){
	state = stiffRicochet.normal;
	function movementX(){
		return movementVector[0]*movementSpeed;
	}
	function movementY(){
		return movementVector[1]*movementSpeed;
	}

	summonObject(obj_enemy_cannon, [["parent", id], ["depth", depth-1]]);
	summonObject(obj_enemy_hitbox, [["parent", id]]);

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
