global.playerBarrelLength = 27;
pauseMode = parent.pauseMode
x = parent.x
y = parent.y
bulletInfo = bulletInfo_create(
	100,
	99,
	1,
	2,
	{fullMetalJacket: false}
)

SignalSubscribe(id, "barrelBulletCompletion", function(completionPercentage){
	image_index = completionPercentage*7
	
});
SignalSubscribe(id, "exitBarrel: " + string(id), function(arg){
	setDelay(function(){image_index++},arg/7,id,noone)
	setDelay(function(){image_index++},arg/7*2,id,noone)
	setDelay(function(){sprite_index = spr_player_cannon},arg/7*3,id,noone)
});

maxBullets = 3;
activeBullets = 0;
firingCooldown = 0;
firingCooldownTime = 30;




subToTriggers(object_index);


