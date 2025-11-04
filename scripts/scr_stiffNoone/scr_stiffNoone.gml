function create_stiffNoone(){
	//todo: sprites
	states = createStates("normal");
	state = states.normal
	valueRange = [10,10];
	hp = 4;
	playerSeen = false;
	wallSeen = 0;

	detectionSquareWidth = 6;

}

function step_stiffNoone(){
	exeStateFunc("stiffNoone_", state);
}