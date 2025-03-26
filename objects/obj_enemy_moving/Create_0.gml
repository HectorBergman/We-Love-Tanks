enum bodyEnemyStates{
	normal,
	spotted,
	prowling,
}

tickrate = 5;
tick = 5;

breadCrumbs = []
nearestCrumb = noone
nearestCrumbDistance = 9999999;
detectionSquareHandlers = []

state = bodyEnemyStates.prowling;
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
distanceY = abs(playerTank.y - y);

playerSeen = false;
wallSeen = 0;

detectionSquareWidth = 6;


