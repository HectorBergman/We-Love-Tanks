enum enemyStates{
	normal,
	scanning,
	spotted,
}
state = enemyStates.scanning;
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


function coordinateFormula(x1,y1,x2,y2,t){
	return [x1+t*(x2-x1),y1+t*(y2-y1)]
}
function findNextCoordinate(stepSize, iteration){
	return coordinateFormula(x,y,playerTank.x,playerTank.y,stepSize*iteration)
}
function getStepSize(){
	return detectionSquareWidth/distance
}