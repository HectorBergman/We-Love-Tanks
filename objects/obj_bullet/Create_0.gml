depth = parent.depth+1
pauseMode = allPause
function movementX(){
	return movementVector[0]*bulletSpeed;
}
function movementY(){
	return movementVector[1]*bulletSpeed;
}
scale = 1;
canGrow = false;
timeWhenExitBarrel = 0
if barrelLength > 0{
	timeWhenExitBarrel = ceil(barrelLength/bulletSpeed)+1;
}
if variable_instance_exists(id, "bulletGrowthStart"){
	canGrow = true;
	scale = bulletGrowthStart;
}
followCannon = 0;
if object_index == obj_bullet_player{
	extraMovement = 0
	followCannon = timeWhenExitBarrel;
}
image_xscale = scale;
image_yscale = scale;
collisionVector = [0,0];
//summonObject(obj_bulletTrail, [["parent", id]]);
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
lifeTime = 0;

pathPoints = ds_list_create();
maxPathLength = 100


pathSurface = -1; 

subToTriggers(string(object_index))


ignoreList = ds_list_create()

growth_factor = 1;
initial_radius = 1; // Starting size
rotation_speed = 3; // Degrees per frame


function bulletBounce(){
	if timeSinceBounce > 5{
		if bounces >= maxBounce{
			death();
		}else{
			timeSinceBounce = 0;
			bounces++
		}
	}
	print("BuletmovVec0: ", movementVector[0], " BuletmovVec1: ", movementVector[1]);
}

function collide(collideEntity, isBullet){
	if ds_list_find_index(ignoreList, collideEntity) != -1{
		exit;
	}else{
		ds_list_add(ignoreList,collideEntity);
	}
	if !isBullet{
		var dmg = damage;
		with collideEntity.parent{
			decreaseHealth(dmg);
		}
		death();
	}else{
		decreaseDurability(collideEntity);
	}
}
function decreaseDurability(collidedEntity){
	var dura = durability;
	durability -= collidedEntity.durability;
	collidedEntity.durability -= dura;
	if durability <= 0{
		death();
	}
	if collidedEntity.durability <= 0{
		with collidedEntity{
			id.death()
		}
	}
}
function death(){
	if increaseCount && instance_exists(parent){
		parent.activeBullets--;
	}
	instance_destroy()
	exit;
}

