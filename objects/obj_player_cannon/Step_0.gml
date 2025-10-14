PAUSE
pickupMoney();
x = parent.x
y = parent.y
image_angle = point_direction(x,y,obj_crosshair.x,obj_crosshair.y) //
firingCooldown--

if obj_inputHandler.fire && !place_meeting(x,y, obj_solid) && activeBullets < maxBullets && firingCooldown < 1{
	var extraInfo = {
		bulletGrowthStart: 0.3, 
		bulletGrowthEnd: 1, 
		bulletGrowthRate: 0.05
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
	
	fireBullet(id,obj_bullet_player,image_angle, args)
	SignalSend("onFire", {id : id, bulletInfo : bulletInfo});
	/*
	var angle = image_angle
	var b_Sp = bulletSpeed
	var b_Bnc = bulletBounces
	var b_D = bulletDamage
	var b_Db = bulletDurability;
	with parent {
		loop_onFire({obj : obj_bullet_player, bulletSpeed : b_Sp, bulletBounces : b_Bnc, bulletDamage : b_D, bulletAngle : angle, bulletDurability : b_Db, extraInfo : extraInfo});
	}*/
}
