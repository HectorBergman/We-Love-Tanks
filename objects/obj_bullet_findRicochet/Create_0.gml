pauseMode = allPause;
function movementX(){
	return movementVector[0]*bulletSpeed;
}
function movementY(){
	return movementVector[1]*bulletSpeed;
}

hitInARow = 0;
collisionVector = [0,0];

prevVector = [noone, noone];
timeSinceBounce = 0;

lastWallStruck = noone;
newCoords = [0,0]
latestWallHit = -1;
closestDistanceToPlayer = distanceNotFound;

bounces = 0;

function ricochetBounce(){
	
	if bounces >= maxBounce{
		instance_destroy();
	}else{
		bounces++
	}
}


var top = y - sprite_get_yoffset(sprite_index)
var bot = y + (sprite_height - sprite_get_yoffset(sprite_index))

//collision_line(x