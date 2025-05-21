function movementX(){
	return movementVector[0]*bulletSpeed;
}
function movementY(){
	return movementVector[1]*bulletSpeed;
}

collisionVector = [0,0];

prevVector = [noone, noone];
timeSinceBounce = 0;
//summonObject(obj_zbullet_visual, [["parent",id]]);
lastWallStruck = noone;
newCoords = [0,0]
latestWallHit = -1;
hitInARow = 0;
slowmovin = 1;
slowMovinTime = 60;

spriteOffset = [sprite_get_xoffset(sprite_index), sprite_get_yoffset(sprite_index)];

angle = point_direction(0,0,movementVector[0],movementVector[1]);
print("lol");
print(angle);
print(movementVector[0]);
print(movementVector[1]);
image_angle = 0;
prevTurn = -1;

minimumdifference = 3;

hitList = ds_list_create();

