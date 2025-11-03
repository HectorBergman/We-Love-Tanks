function create_braveheartNormal(){
	_health = 1;
	tickrate = 5;
	tick = 5;
	movementSpeed = 1;

	breadCrumbs = []
	nearestCrumb = noone
	nearestCrumbDistance = 9999999;
	detectionSquareHandlers = []
	hp = 8;
	
	states = createStates("approaching","patrolling","spotted");
	state = states.approaching;
	

	distance = 0
	distanceX = abs(obj_player.x - x);
	distanceY = abs(obj_player.y - y);

	playerSeen = false;
	wallSeen = 0;
	targetSquare = noone;

	detectionSquareWidth = 6;
	
	timeSinceLastSquare = 0;
	timeSinceLastSquareLim = 120;
}
//move ts

function step_braveheartNormal(){
	
	exeStateFunc("braveheartNormal_",state);

}