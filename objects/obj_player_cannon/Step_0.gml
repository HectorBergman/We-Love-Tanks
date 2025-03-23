x = parent.x
y = parent.y
image_angle = point_direction(x,y,mouse_x,mouse_y)
firingCooldown--

if parent.fire && !place_meeting(x,y, obj_wall) && activeBullets < 3 && firingCooldown < 1{
	var angle = degtorad(image_angle)+pi/2
	summonObject(obj_bullet, [["movementVector", [sin(angle), cos(angle)]], 
	["bulletSpeed", 3], ["x", x+20*sin(angle)], ["y", y+20*cos(angle)], ["maxBounce", 3], ["parent", id]]);
	activeBullets++;
	firingCooldown = firingCooldownTime;
}