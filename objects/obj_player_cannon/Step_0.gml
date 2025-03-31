x = parent.x
y = parent.y
image_angle = point_direction(x,y,mouse_x,mouse_y) //
firingCooldown--

if parent.fire && !place_meeting(x,y, obj_wall) && activeBullets < maxBullets && firingCooldown < 1{
	fireBullet(obj_bullet,1.5,5);
}