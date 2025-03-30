function enemyState_normal_cannon(){
	firingCooldown--
	if !(collision_line(x, y, playerTank.x, playerTank.y, obj_wall, false, true)){
		image_angle = point_direction(x,y,playerTank.x,playerTank.y)

	}else{
		state = cannonEnemyStates.scanning;
		scanningPoint = image_angle
		scanningDirection = sign(random_range(-1, 1));

	}
	if !place_meeting(x,y, obj_wall) && activeBullets < 3 && firingCooldown < 1{
		fireBullet(obj_bullet_enemy, 1.5, 3)	
	}
}