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
hitInARow = 0;
slowmovin = 1;
slowMovinTime = 60;
angle = image_angle
prevTurn = -1;
bounces = 0;

minimumdifference = 3;



function bulletBounce(){
	if timeSinceBounce > 5{
		if bounces >= maxBounce{
			instance_destroy();
		}else{
			timeSinceBounce = 0;
			bounces++
		}
	}
}

function death(){
	instance_destroy()
}
