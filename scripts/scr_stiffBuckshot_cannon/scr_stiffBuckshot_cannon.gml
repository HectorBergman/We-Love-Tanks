function create_cannon_stiffBuckshot(){
	
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
	states = createStates("firing", "scanning", "spotted");
	state = states.firing;

	scanningArea = pi/2
	scanningStep = (pi/2)/100
	scanningPoint = degtorad(point_direction(x,y,obj_player.x,obj_player.y));

	stepTilSwitchWhole = 200;
	stepsTilSwitch = stepTilSwitchWhole/2;
	image_angle = radtodeg(scanningPoint);
	playerSeenLastStep = false;
	scanningDirection = 1;

}

function step_cannon_stiffBuckshot(){
	x = parent.x
	y = parent.y
	firingCooldown--
	exeStateFunc("stiffBuckshot_cannon_",state)
}