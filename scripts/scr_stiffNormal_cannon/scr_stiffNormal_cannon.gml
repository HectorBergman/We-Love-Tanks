function stiffNormal_create_cannon(){
	

	x = parent.x
	y = parent.y
	activeBullets = 0;
	firingCooldown = 0;
	firingCooldownTime = 60;
	
	rapidCooldownLimit = 120;
	rapidCooldown = 0;
	rapidCool = false;
	
	fire = false;
	state = cannonEnemyStates.scanning;

	scanningArea = pi/2
	scanningStep = (pi/2)/100
	scanningPoint = degtorad(point_direction(x,y,playerTank.x,playerTank.y));

	stepTilSwitchWhole = 200;
	stepsTilSwitch = stepTilSwitchWhole/2;
	image_angle = radtodeg(scanningPoint);
	playerSeenLastStep = false;
	scanningDirection = 1;

}

function stiffNormal_step_cannon(){
	x = parent.x
	y = parent.y
	firingCooldown--

	switch (state){
	    case stiffNormal_cannon.firing: stiffNormal_cannon_firing(); break;
		case stiffNormal_cannon.scanning: stiffNormal_cannon_scanning(); break;
		case stiffNormal_cannon.spotted: stiffNormal_cannon_spotted(); break;
	}

}