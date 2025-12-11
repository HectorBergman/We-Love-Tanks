PAUSE
hit--;


switch(phase){
	case bossPhase.startingUp:{
		startUpTimer--
		if startUpTimer == 0{
			phase = bossPhase.active;
		}
	}break;
	case bossPhase.active:{
		if checkForDeath(){
			exit;
		}

		exeStateFunc("step_", type);
	}break;
}
//x += movementVector[0]*movementSpeed;
//y += movementVector[1]*movementSpeed;
