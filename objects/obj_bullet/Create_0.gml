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
lifeTime = 0;

pathPoints = ds_list_create();
maxPathLength = 100


pathSurface = -1; 


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
	loop_onBulletTravel();
	
	instance_destroy()
	exit;
}

