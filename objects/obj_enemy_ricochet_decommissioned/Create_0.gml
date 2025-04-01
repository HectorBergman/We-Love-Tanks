
state = enemyStates.scanning;
function movementX(){
	return movementVector[0]*movementSpeed;
}
function movementY(){
	return movementVector[1]*movementSpeed;
}

summonObject(obj_enemy_cannon_ricochet_decommissioned, [["parent", id], ["depth", depth-1]]);
summonObject(obj_enemy_hitbox_ricochet_decommissioned, [["parent", id]]);

distance = point_distance(x, y, playerTank.x, playerTank.y);
distanceX = abs(playerTank.x - x);
distanceY = abs(playerTank.y - y);

playerSeen = false;
wallSeen = 0;

detectionSquareWidth = 6;


