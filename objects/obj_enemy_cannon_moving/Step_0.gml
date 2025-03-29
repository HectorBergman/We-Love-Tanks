x = parent.x
y = parent.y
firingCooldown--

switch (state){
    case cannonEnemyStates.normal: enemyState_normal_cannon(); break;
	case cannonEnemyStates.scanning: enemyState_scanning_cannon_moving(); break;
	case cannonEnemyStates.spotted: enemyState_spotted_cannon_moving(); break;
}


