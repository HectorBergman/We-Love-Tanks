function stiffNormal_create_cannon(){
	
	bulletInfo = bulletInfo_create(
		1,
		3,
		1,
		2
	)
	x = parent.x
	y = parent.y
	activeBullets = 0;
	firingCooldown = 0;
	firingCooldownTime = 60;
	
	rapidCooldownLimit = 120;
	rapidCooldown = 0;
	rapidCool = false;
	
	fire = false;

	states = createStates("firing","scanning","spotted");
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

function stiffNormal_step_cannon(){
	x = parent.x
	y = parent.y
	firingCooldown--
	
	exeStateFunc("stiffNormal_cannon_", state)
}