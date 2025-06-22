function testStar_create(){
	enum testStarStates{
		normal
	}
	state = testStarStates.normal
	dir = random_range(0,360);
	movementVector = [lengthdir_x(1,dir),lengthdir_y(1,dir)]
	velocity = 3;
}
function testStar_step(){
	switch (state){
		case testStarStates.normal: testStar_normal(); break;
	}
}

function testStar_normal(){
	ricochet(movementVector,3,110,22);
	x += movementVector[0]*velocity
	y += movementVector[1]*velocity
}