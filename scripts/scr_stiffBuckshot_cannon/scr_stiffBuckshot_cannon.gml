function stiffBuckshot_create_cannon(){
	
	bulletInfo = bulletInfo_create(
		1,
		2,
		1,
		1
	)
	x = parent.x
	y = parent.y
	activeBullets = 0;
	firingCooldown = 0;
	firingCooldownTime = 180;
	buckshotBullets = [];
	
	
	fire = false;
	state = stiffBuckshot_cannon.firing;

	scanningArea = pi/2
	scanningStep = (pi/2)/100
	scanningPoint = degtorad(point_direction(x,y,obj_player.x,obj_player.y));

	stepTilSwitchWhole = 200;
	stepsTilSwitch = stepTilSwitchWhole/2;
	image_angle = radtodeg(scanningPoint);
	playerSeenLastStep = false;
	scanningDirection = 1;

}

function stiffBuckshot_step_cannon(){
	x = parent.x
	y = parent.y
	firingCooldown--

	switch (state){
	    case stiffNormal_cannon.firing: stiffBuckshot_cannon_firing(); break;
		case stiffNormal_cannon.scanning: stiffBuckshot_cannon_scanning(); break;
		case stiffNormal_cannon.spotted: stiffBuckshot_cannon_spotted(); break;
	}

}