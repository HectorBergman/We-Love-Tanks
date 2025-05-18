function braveheartNormal_create(){
	_health = 1;
	tickrate = 5;
	tick = 5;
	movementSpeed = 1;

	breadCrumbs = []
	nearestCrumb = noone
	nearestCrumbDistance = 9999999;
	detectionSquareHandlers = []


	state = braveheartNormal.approaching;
	

	distance = point_distance(x, y, playerTank.x, playerTank.y);
	distanceX = abs(playerTank.x - x);
	distanceY = abs(playerTank.y - y);

	playerSeen = false;
	wallSeen = 0;

	detectionSquareWidth = 6;
}
//move ts

function braveheartNormal_step(){
	
	
	switch (state){
		case braveheartNormal.approaching: braveheartNormal_approaching(); break;
		case braveheartNormal.patrolling: braveheartNormal_patrolling(); break;
		case braveheartNormal.spotted: braveheartNormal_spotted(); break;
	}

	

}