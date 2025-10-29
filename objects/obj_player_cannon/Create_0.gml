#macro bulgeLock {lock: false, state: false}

global.playerBarrelLength = 27;
pauseMode = parent.pauseMode
x = parent.x
y = parent.y
bulletInfo = bulletInfo_create(
	100,
	0,
	1,
	2,
	{fullMetalJacket: false}
)

animStates = createStates("normal","charging","releasing");
animState = animStates.normal;

barrelQueue = ds_queue_create();
barrelBulges = [bulgeLock,bulgeLock,bulgeLock,bulgeLock,bulgeLock];
bulgeCount = 0;

animInfo = {
	frame : 0,
	frameSpeed : 0.12*(bulgeCount+1),
}

SignalSubscribe(id, "barrelBulletExitBulge", function(exitNo){
	print("exitBulge");
	if !barrelBulges[exitNo].lock{
		barrelBulges[exitNo].state = false;
		bulgeCount--;
		print("test")
		print(exitNo);
	}
	if exitNo < array_length(barrelBulges)-1{
		barrelBulges[exitNo+1].state = true;
		barrelBulges[exitNo+1].lock = true;
		bulgeCount++;
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
	for (var i = 0; i < array_length(barrelBulges); i++){
		barrelBulges[i].lock = false;
	}
	animInfo.frameSpeed = 0.12*(bulgeCount+1);
}


maxBullets = 999;
activeBullets = 0;
firingCooldown = 0;
firingCooldownTime = 5;




subToTriggers(object_index);


