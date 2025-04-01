

tickrate = 5;
tick = 5;
movementSpeed = 0.5;

breadCrumbs = []
nearestCrumb = noone
nearestCrumbDistance = 9999999;
detectionSquareHandlers = []


state = bodyEnemyStates.approaching;
function movementX(){
	return movementVector[0]*movementSpeed;
}
function movementY(){
	return movementVector[1]*movementSpeed;
}
movementVector = [0,0];

summonObject(obj_enemy_cannon_moving_decommissioned, [["parent", id], ["depth", depth-1]]);
hitbox = summonObject(obj_enemy_hitbox_moving_decommissioned, [["parent", id]]);

distance = point_distance(x, y, playerTank.x, playerTank.y);
distanceX = abs(playerTank.x - x);
distanceY = abs(playerTank.y - y);

playerSeen = false;
wallSeen = 0;

detectionSquareWidth = 6;


