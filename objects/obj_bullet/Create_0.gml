depth = parent.depth+1
pauseMode = allPause
function movementX(){
	return movementVector[0]*bulletSpeed;
}
function movementY(){
	return movementVector[1]*bulletSpeed;
}



states = createStates("inBarrel","travel","bounce","dying");
state = states.inBarrel;

growthStates = createStates("growing","grown");
growthState = growthStates.grown;

bounceStates = createStates("start","mid","finish");

print("moner");
if variable_instance_exists(id, "bulletGrowthStart"){
	growthState = growthStates.growing;
	scale = bulletGrowthStart;
}

var bounceMulti = 0;
if variable_instance_exists(id,"boostMultiplier"){
	bounceMulti = boostMultiplier;
}
var decay = 0.99;
if variable_instance_exists(id,"boostDecay"){
	decay = boostDecay;
}
var bounceFrames = 2;
if variable_instance_exists(id,"bounceFrameCount"){
	bounceFrames = bounceFrameCount;
}

bInfo = {
	angle : undefined,
	angleAtBounce : undefined,
	impactPoint : undefinedCoords,
	endCoords : undefinedCoords,
	state : bounceStates.start,
	
	bounceTime : bounceFrames,
	bounceTimer : bounceFrames,
	bounces : maxBounce,
	timeSinceBounceGrace : 5,
	timeSinceBounce : 0,
	boostMultiplier : bounceMulti,
	boostDecay : decay,
	lastEasedProgress : 0,
}

scale = 1;

timeWhenExitBarrel = 0
if barrelLength > 0{
	timeWhenExitBarrel = ceil(barrelLength/bulletSpeed)+1;
	extraMovement = 0
	followCannon = timeWhenExitBarrel;
}else{
	state = state.travel
}



image_xscale = scale;
image_yscale = scale;



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
		state = states.dying;
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

function bullet_tick(){
	if bulletSpeed > capBulletSpeed{
		bulletSpeed = capBulletSpeed;
	}
	if inRange(bulletSpeed, baseBulletSpeed-0.05,baseBulletSpeed+0.05){
		bulletSpeed = baseBulletSpeed;
	}else if bulletSpeed > baseBulletSpeed{
		bulletSpeed*=bInfo.boostDecay;
	}
	bInfo.timeSinceBounce++
	
	if object_index == obj_bullet_player{
		pickupMoney();
		SignalSend("onBulletTravel", {id : id});
	}
	
	image_angle = point_direction(x,y,x+movementVector[0],y+movementVector[1]);
	x = x + movementX();
	y = y + movementY();
}

function bullet_checkForRico(){
	var rico = findRicochet(movementVector, bulletSpeed)
	if rico != -1{
		if bInfo.bounces == 0{
			state = states.dying;
			bullet_tick()
		}else{
			SignalSend("flare", {x:x,y:y});
			var movVecTest = getMovementVector(rico)
			if collision_circle(x+movVecTest[0]*bulletSpeed,y+movVecTest[1]*bulletSpeed,3,obj_solid,true,true){
				rico = (image_angle+180) mod 360
			}
			state = states.bounce;
			bInfo.angle = rico;
			bInfo.angleAtBounce = image_angle;
			if bInfo.timeSinceBounce > bInfo.timeSinceBounceGrace{
				bInfo.bounces--
			}
			bInfo.impactPoint = [x,y]
			bInfo.timeSinceBounce = 0;
		}
	}
}

