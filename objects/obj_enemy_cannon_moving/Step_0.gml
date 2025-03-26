x = parent.x
y = parent.y
state = parent.state;
firingCooldown--

switch (state){
    case enemyStates.normal: enemyState_normal_cannon(); break;
	case enemyStates.scanning: enemyState_scanning_cannon(); break;
	case enemyStates.spotted: enemyState_spotted_cannon(); break;
}


