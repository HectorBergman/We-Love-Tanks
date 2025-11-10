#macro bulgeLock []

global.playerBarrelLength = 25;
pauseMode = parent.pauseMode
x = parent.x
y = parent.y
bulletInfo = bulletInfo_create(
	100,
	1,
	1,
	2,
	{fullMetalJacket: false}
)
maxBullets = 99;
activeBullets = 0;
firingCooldown = 0;
firingCooldownTime = 60;

SignalSubscribe(id, "deleteBulge: " + string(id), function(arg){
	for (var i = 0; i < array_length(barrelBulges); i++){
		if array_length(barrelBulges[i]) != 0{
			if findBulge(i, arg){ 
				exit;
			}
		}
	}
})
animStates = createStates("normal","charging","releasing");
animState = animStates.normal;

SignalSubscribe(id, "roomEntered: newRoom", function(){
	barrelBulges = [bulgeLock,bulgeLock,bulgeLock,bulgeLock,bulgeLock];
});

barrelQueue = ds_queue_create();
barrelBulges = [bulgeLock,bulgeLock,bulgeLock,bulgeLock,bulgeLock];

animInfo = {
	frame : 0,
	frameSpeed : 0.12,
}

SignalSubscribe(id, "barrelBulletExitBulge: " + string(id), function(exitInfo){
	
	var prevProg = exitInfo.prevProg
	var nowProg = exitInfo.nowProg
	var bullet = exitInfo.bullet;
	var n = array_length(barrelBulges);
	
	
    var startBulge = floor(prevProg * n);
    if (startBulge >= n){
		startBulge = n - 1; 
	}
    var endBulge = floor(nowProg * n);
	
	
    if (endBulge >= n){
		findBulge(n-1,bullet);
		return;
	}

    var passed = endBulge - startBulge;
    if (passed > 0) {
		var trueid = startBulge+passed
		barrelBulges[trueid][array_length(barrelBulges[trueid])] = bullet;
    }else{
		return
	}

	
    for (var i = 0; i < passed; i++) {
        var idx = (startBulge + i)
		findBulge(idx,bullet);
	}   

});

function findBulge(idx, bullet){
	var bulletMatcher = method({
		bullet: bullet
	}, function(value, index) {
		return value == bullet;
	});

	var found = array_find_index(barrelBulges[idx], bulletMatcher);
    if (found != -1) {
		array_delete(barrelBulges[idx], found, 1);
		return true;
	}
	return false;
}
SignalSubscribe(id, "exitBarrel: " + string(id), function(arg){
	if animState != animStates.releasing{
		animState = animStates.releasing;
		sprite_index = spr_player_cannon_firingAnim_1
	}
	ds_queue_dequeue(barrelQueue);
});

function countBulge(){
	var bulgeCount = 0;
	for (var i = 0; i < array_length(barrelBulges); i++){
		bulgeCount += sign(array_length(barrelBulges[i]))
	}
	
	animInfo.frameSpeed = 0.14*(power(bulgeCount+1,2));
}




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
	var bullet = fireBullet(id,obj_bullet_player,image_angle, args)
	ds_queue_enqueue(barrelQueue, bullet)
	barrelBulges[0][array_length(barrelBulges[0])] = bullet
}




subToTriggers(object_index);


