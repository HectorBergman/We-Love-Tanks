PAUSE
x = parent.x
y = parent.y
image_angle = point_direction(x,y,obj_crosshair.x,obj_crosshair.y) //
firingCooldown--

if obj_inputHandler.fire && !place_meeting(x,y, obj_solid) && activeBullets < maxBullets && firingCooldown < 1{
	fireBullet(obj_bullet_player,bulletSpeed,2,3,image_angle, 34,true);
	var angle = image_angle
	var bulletSp = bulletSpeed
	with parent {
		loop_onFire([obj_bullet_player,bulletSp,2,3,angle]);
	}
}