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
	dying,
}
enum bounceState{
	start,
	mid,
	finish,
}
enum growthState{
	growing,
	grown
}

state = bulletState.inBarrel;
growth = growthState.grown;

bInfo = {
	angle : undefined,
	angleAtBounce : undefined,
	impactPoint : undefinedCoords,
	endCoords : undefinedCoords,
	state : bounceState.start,
	
	bounceTime : 2,
	bounceTimer : 5,
	frameTurnMax : 0.1,
	bounces : maxBounce,
}

scale = 1;

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

baseBulletSpeed = bulletSpeed;
capBulletSpeed = baseBulletSpeed*4;


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

function getMovementVector(angle){
	return [cos(degtorad(angle)), -sin(degtorad(angle))]
}

function getBounceTrueCoords(){
	var angleDiff = angle_difference(bInfo.angle, bInfo.angleAtBounce)
	print("angleDiff: ",angleDiff);
	var backPointPercent = (1-abs(angleDiff)/180)
	print("backPointPercent: ", backPointPercent);
	var offset = sprite_yoffset;
	var height = sprite_height;
	print(sprite_yoffset)
	print(sprite_height);
	var top = - offset;
	var bot = - offset + height;
	
	var trueYoffset = 0;
	print(sign(angleDiff));
	switch (sign(angleDiff)){
		case -1: 
			trueYoffset = bot*backPointPercent;
		break;
		case 1: 
			trueYoffset = top*backPointPercent;
		break;
		case 0: trueYoffset = 0; break;
	}
	print("trueYOffset: ", trueYoffset);
	var finishX = sprite_xoffset*dsin(bInfo.angle) + trueYoffset*dcos(bInfo.angle)
	var finishY = sprite_xoffset*dcos(bInfo.angle) + trueYoffset*dsin(bInfo.angle)
	print("finishX: ", finishX)
	print("finishY: ", finishY);
	print(bInfo.impactPoint);
	return [bInfo.impactPoint[0]-finishX,bInfo.impactPoint[1]-finishY]
}

function bullet_travel(){
	if bulletSpeed > capBulletSpeed{
		bulletSpeed = capBulletSpeed;
	}
	if inRange(bulletSpeed, baseBulletSpeed-0.05,baseBulletSpeed+0.05){
		bulletSpeed = baseBulletSpeed;
	}else if bulletSpeed > baseBulletSpeed{
		bulletSpeed*=0.99;
	}
	
	image_angle = point_direction(x,y,x+movementVector[0],y+movementVector[1]);
	x = x + movementX();
	y = y + movementY();
}

function bullet_checkForRico(){
	var rico = findRicochet(movementVector, bulletSpeed)
	if rico != -1{
		if bInfo.bounces == 0{
			state = bulletState.dying;
		}else{
			state = bulletState.bounce;
			bInfo.angle = rico;
			bInfo.angleAtBounce = image_angle;
			bInfo.bounces--
			bInfo.impactPoint = [x,y]
			//bInfo.endCoords = getBounceTrueCoords()
		}
	}
}