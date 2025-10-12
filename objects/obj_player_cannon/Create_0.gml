global.playerBarrelLength = 27;
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




maxBullets = 3;
activeBullets = 0;
firingCooldown = 0;
firingCooldownTime = 30;




subToTriggers(object_index);