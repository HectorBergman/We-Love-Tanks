#macro bulgeLock {lock: false, state: false}

global.playerBarrelLength = 25;
pauseMode = parent.pauseMode
x = parent.x
y = parent.y
bulletInfo = bulletInfo_create(
	100,
	3,
	1,
	2,
	{fullMetalJacket: false}
)
print("cannonId: ", id);
animStates = createStates("normal","charging","releasing");
animState = animStates.normal;

barrelQueue = ds_queue_create();
barrelBulges = [bulgeLock,bulgeLock,bulgeLock,bulgeLock,bulgeLock];

animInfo = {
	frame : 0,
	frameSpeed : 0.12,
}

SignalSubscribe(id, "barrelBulletExitBulge", function(exitNo){
	print("exitBulge");
	if !barrelBulges[exitNo].lock{
		barrelBulges[exitNo].state = false;
		print("test")
		print(exitNo);
	}
	if exitNo < array_length(barrelBulges)-1{
		barrelBulges[exitNo+1].state = true;
		barrelBulges[exitNo+1].lock = true;
	}
});
SignalSubscribe(id, "exitBarrel: " + string(id), function(arg){
	if animState != animStates.releasing{
		animState = animStates.releasing;
		sprite_index = spr_player_cannon_firingAnim_1
	}
	ds_queue_dequeue(barrelQueue);
});

function resetLocks(){
	var bulgeCount = 0;
	for (var i = 0; i < array_length(barrelBulges); i++){
		barrelBulges[i].lock = false;
		bulgeCount += barrelBulges[i].state
	}
	
	animInfo.frameSpeed = 0.14*(power(bulgeCount+1,2));
	print("lol: ",power(bulgeCount+1,2));
}


maxBullets = 999;
activeBullets = 0;
firingCooldown = 0;
firingCooldownTime = 5;

function playerFire(){
	var extraInfo = {
		bulletGrowthStart: 0.3, 
		bulletGrowthEnd: 1, 
		bulletGrowthRate: 0.05,
		boostMultiplier: 0.8,
		boostDecay: 0.99,
		bounceFrameCount : 8,
		bulgeAmount : array_length(barrelBulges),
		bulgeNumber : 0,
	}
	
	var args = 
	fireBullet_defaultSummonStruct(
		bulletInfo.speed,
		bulletInfo.bounces,
		bulletInfo.damage,
		global.playerBarrelLength, 
		bulletInfo.durability,
		extraInfo
	)
	
	ds_queue_enqueue(barrelQueue, fireBullet(id,obj_bullet_player,image_angle, args))
	barrelBulges[0].state = true;
	barrelBulges[0].lock = true;
	
}




subToTriggers(object_index);


