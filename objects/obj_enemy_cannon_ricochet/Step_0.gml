x = parent.x
y = parent.y
shotCooldown--
if (shotCooldown == 20){
	findBestRicochetAngle();
}else if (shotCooldown == 0){
	searchRicochetArray();
	image_angle = chosenAngle;
	fireBullet(obj_bullet_enemy, bulletSpeed, 3)
	shotCooldown = shotCooldownTime
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