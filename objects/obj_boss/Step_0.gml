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
		checkForDeath();

		switch(type){
			case bossTypes.testStar : testStar_step(); break;

		}
	}break;
}
 x += movementVector[0]*movementSpeed;
 y += movementVector[1]*movementSpeed;
