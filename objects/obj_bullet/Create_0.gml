function movementX(){
	return movementVector[0]*bulletSpeed;
}
function movementY(){
	return movementVector[1]*bulletSpeed;
}

collisionVector = [0,0];

prevVector = [noone, noone];
timeSinceBounce = 0;

lastWallStruck = noone;
newCoords = [0,0]
latestWallHit = -1;

slowmovin = 1;
slowMovinTime = 60;

prevTurn = -1;

minimumdifference = 3;

hitList = ds_list_create();