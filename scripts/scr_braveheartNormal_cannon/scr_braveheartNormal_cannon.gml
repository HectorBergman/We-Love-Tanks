function braveheartNormal_create_cannon(){
	x = parent.x
	y = parent.y
	activeBullets = 0;
	firingCooldown = 0;
	firingCooldownTime = 900;
	fire = false;
	state = braveheartNormal_cannon.scanning;

	scanningArea = pi/2
	scanningStep = (pi/2)/100
	scanningPoint = degtorad(point_direction(x,y,playerTank.x,playerTank.y));

	stepTilSwitchWhole = 200;
	stepsTilSwitch = stepTilSwitchWhole/2;
	image_angle = radtodeg(scanningPoint);
	playerSeenLastStep = false;
	scanningDirection = 1;
}

function braveheartNormal_step_cannon(){
	x = parent.x
	y = parent.y
	firingCooldown--

	switch (state){
	    case braveheartNormal_cannon.firing: braveheartNormal_firing_cannon(); break;
		case braveheartNormal_cannon.scanning: braveheartNormal_scanning_cannon(); break;
		case braveheartNormal_cannon.spotted: braveheartNormal_spotted_cannon(); break;
	}



}