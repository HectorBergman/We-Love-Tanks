function create_cannon_stiffNoone(){
	
	bulletInfo = bulletInfo_create(
		1,
		3,
		1,
		2
	)
	x = parent.x
	y = parent.y

	states = createStates("normal")
	state = states.normal


}

function step_cannon_stiffNoone(){
	x = parent.x
	y = parent.y
	
	exeStateFunc("stiffNoone_cannon_", state)
}