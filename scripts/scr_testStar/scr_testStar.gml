function testStar_create(){
	enum testStarStates{
		normal
	}
	states = createStates("normal");
	state = states.normal;
	dir = random_range(0,360);
	movementVector = [lengthdir_x(1,dir),lengthdir_y(1,dir)]
	velocity = 3;
}
function testStar_step(){
	exeStateFunc("testStar_",state);
}

function testStar_normal(){
	ricochet(movementVector,3,110,22);
	x += movementVector[0]*velocity
	y += movementVector[1]*velocity
}