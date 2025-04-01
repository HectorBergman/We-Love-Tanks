x = parent.x
y = parent.y
shotCooldown++
if (shotCooldown mod shotCooldownTime == shotCooldownTime-maxBounces-timeFromCalculationToFire){
	findBestRicochetAngle();
}else if shotCooldown mod shotCooldownTime == shotCooldownTime-timeFromCalculationToFire+10{
	searchRicochetArray();
	stepAngle = gradualPointOverTime(chosenAngle, timeFromCalculationToFire-10)
}else if (shotCooldown mod shotCooldownTime == 0){
	image_angle = chosenAngle;
	fireBullet(obj_bullet_enemy, bulletSpeed, 3)
	chosenAngle = -1;
	closestDistanceToPlayer = 999999;
}else if(shotCooldown mod shotCooldownTime > shotCooldownTime-timeFromCalculationToFire+10){
	if (abs(angle_difference(image_angle, chosenAngle)) < 3){
		image_angle = chosenAngle
	}else{
		image_angle += stepAngle;
	}
}
/*
switch (state){
    case cannonEnemyStates.normal: enemyState_normal_cannon(); break;
	case cannonEnemyStates.scanning: enemyState_scanning_cannon(); break;
	case cannonEnemyStates.spotted: enemyState_spotted_cannon(); break;
}


*/