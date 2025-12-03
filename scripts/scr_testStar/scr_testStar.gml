function create_testStar(){
	
	states_star = createStates("normal");
	state_star = states_star.normal;
	dir = random_range(0,360);
	movementVector = [lengthdir_x(1,dir),lengthdir_y(1,dir)]
	velocity = 3;
}
function step_testStar(){
	exeStateFunc("testStar_",state_star);
}

function testStar_normal(){
	ricochet(movementVector,3,110,22);
	x += movementVector[0]*velocity
	y += movementVector[1]*velocity
}