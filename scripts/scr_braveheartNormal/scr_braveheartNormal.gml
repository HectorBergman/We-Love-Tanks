function braveheartNormal_create(){
	_health = 1;
	tickrate = 5;
	tick = 5;
	movementSpeed = 1;

	breadCrumbs = []
	nearestCrumb = noone
	nearestCrumbDistance = 9999999;
	detectionSquareHandlers = []
	hp = 8;

	state = braveheartNormal.approaching;
	

	distance = 0
	distanceX = abs(playerTank.x - x);
	distanceY = abs(playerTank.y - y);

	playerSeen = false;
	wallSeen = 0;
	targetSquare = noone;

	detectionSquareWidth = 6;
	
	timeSinceLastSquare = 0;
	timeSinceLastSquareLim = 120;
}
//move ts

function braveheartNormal_step(){
	
	
	switch (state){
		case braveheartNormal.approaching: braveheartNormal_approaching(); break;
		case braveheartNormal.patrolling: braveheartNormal_patrolling(); break;
		case braveheartNormal.spotted: braveheartNormal_spotted(); break;
	}

	

}