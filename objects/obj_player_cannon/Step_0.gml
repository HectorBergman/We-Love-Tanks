PAUSE
pickupMoney();
x = parent.x
y = parent.y
image_angle = point_direction(x,y,obj_crosshair.x,obj_crosshair.y) //
firingCooldown--
var tip_x = x + -8 * dsin(image_angle+90);
var tip_y = y + -8 * dcos(image_angle+90);
if obj_handler_input.fire && !place_meeting(tip_x,tip_y, obj_solid) && activeBullets < maxBullets && firingCooldown < 1{
	playerFire();
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
exeStateFunc("barrelAnim_",animState);

for (var i = 0; i < array_length(barrelBulges); i++){
	for (var j = 0; j < array_length(barrelBulges[i]); j++){
		print("Id: ", barrelBulges[i][j]);
		print("obj_index: ", barrelBulges[i][j].object_index);
	}
}

