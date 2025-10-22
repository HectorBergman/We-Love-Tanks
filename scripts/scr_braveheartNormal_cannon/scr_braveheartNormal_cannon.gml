function braveheartNormal_create_cannon(){
	x = parent.x
	y = parent.y
	bulletInfo = bulletInfo_create(
		1,
		3,
		1,
		2
	)

	activeBullets = 0;
	firingCooldown = 0;
	firingCooldownTime = 900;
	fire = false;
	
	states = createStates("scanning","spotted","firing")
	state = states.scanning;

	scanningArea = pi/2
	scanningStep = (pi/2)/100
	scanningPoint = degtorad(point_direction(x,y,obj_player.x,obj_player.y));

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

	exeStateFunc("braveheartNormal_cannon_", state)


}