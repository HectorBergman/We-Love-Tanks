PAUSE
pickupMoney();
x = parent.x
y = parent.y
image_angle = point_direction(x,y,obj_crosshair.x,obj_crosshair.y) //
firingCooldown--
var tip_x = x + 8 * dsin(image_angle+90);
var tip_y = y + 8 * dcos(image_angle+90);
if obj_inputHandler.fire && !place_meeting(tip_x,tip_y, obj_solid) && activeBullets < maxBullets && firingCooldown < 1{
	var extraInfo = {
		bulletGrowthStart: 0.3, 
		bulletGrowthEnd: 1, 
		bulletGrowthRate: 0.05,
		boostMultiplier: 0.8,
		boostDecay: 0.99,
		bounceFrameCount : 8,
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
	sprite_index = spr_player_cannon_firingAnim
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
