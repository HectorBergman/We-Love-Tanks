function enemyState_normal_cannon(){
	firingCooldown--
	if (parent.wallSeen < 3 && parent.playerSeen){
	
		image_angle = point_direction(x,y,playerTank.x,playerTank.y)

	}else{
		parent.state = enemyStates.scanning;
		scanningPoint = image_angle
		scanningDirection = sign(random_range(-1, 1));

	}
	if !place_meeting(x,y, obj_wall) && activeBullets < 3 && firingCooldown < 1{
		var angle = degtorad(image_angle)+pi/2
		summonObject(obj_bullet_enemy, [["movementVector", [sin(angle), cos(angle)]], 
		["bulletSpeed", 3], ["x", x+20*sin(angle)], ["y", y+20*cos(angle)], ["maxBounce", 3], ["parent", id]]);
		activeBullets++;
		firingCooldown = firingCooldownTime;
	}
}