depth = parent.depth+1
pauseMode = allPause
function movementX(){
	return movementVector[0]*bulletSpeed;
}
function movementY(){
	return movementVector[1]*bulletSpeed;
}

enum bulletState{
	inBarrel,
	travel,
	bounce,
}
enum growthState{
	growing,
	grown
}

state = bulletState.inBarrel;
growth = growthState.grown;
scale = 1;
canGrow = false;
timeWhenExitBarrel = 0
if barrelLength > 0{
	timeWhenExitBarrel = ceil(barrelLength/bulletSpeed)+1;
	extraMovement = 0
	followCannon = timeWhenExitBarrel;
}else{
	state = bulletState.travel;
}

if variable_instance_exists(id, "bulletGrowthStart"){
	growth = growthState.growing;
	scale = bulletGrowthStart;
}

image_xscale = scale;
image_yscale = scale;
timeSinceBounce = 0;


slowmovin = 1;
slowMovinTime = 60;

bounces = 0;

lifeTime = 0;

pathPoints = ds_list_create();
maxPathLength = 100


pathSurface = -1; 

subToTriggers(string(object_index))


ignoreList = ds_list_create()

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

