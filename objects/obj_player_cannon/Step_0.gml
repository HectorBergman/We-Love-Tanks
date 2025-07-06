PAUSE
pickupMoney();
x = parent.x
y = parent.y
image_angle = point_direction(x,y,obj_crosshair.x,obj_crosshair.y) //
firingCooldown--

if obj_inputHandler.fire && !place_meeting(x,y, obj_solid) && activeBullets < maxBullets && firingCooldown < 1{
	fireBullet(obj_bullet_player,bulletSpeed,bulletBounces,bulletDamage,image_angle, 34, true, bulletDurability);
	var angle = image_angle
	var b_Sp = bulletSpeed
	var b_Bnc = bulletBounces
	var b_D = bulletDamage
	var b_Db = bulletDurability;
	with parent {
		loop_onFire({obj : obj_bullet_player, bulletSpeed : b_Sp, bulletBounces : b_Bnc, bulletDamage : b_D, bulletAngle : angle, bulletDurability : b_Db});
	}
}