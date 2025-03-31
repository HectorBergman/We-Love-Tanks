x = parent.x
y = parent.y
shotCooldown++
if (shotCooldown mod shotCooldownTime == shotCooldownTime-maxBounces-1){
	findBestRicochetAngle();
}else if (shotCooldown mod shotCooldownTime == 0){
	searchRicochetArray();
	image_angle = chosenAngle;
	fireBullet(obj_bullet_enemy, bulletSpeed, 3)
	chosenAngle = -1;
	closestDistanceToPlayer = 999999;
}
/*
switch (state){
    case cannonEnemyStates.normal: enemyState_normal_cannon(); break;
	case cannonEnemyStates.scanning: enemyState_scanning_cannon(); break;
	case cannonEnemyStates.spotted: enemyState_spotted_cannon(); break;
}


*/