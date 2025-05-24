switch(phase){
	case enemyPhase.startingUp:{
		startUpTimer--
		if startUpTimer == 0{
			phase = enemyPhase.active;
		}
	}break;
	case enemyPhase.active:{
		checkForDeath();

		switch(type){
			case enemyTypes.stiffNormal: stiffNormal_step(); break;
			case enemyTypes.braveheartNormal: braveheartNormal_step(); break;
			case enemyTypes.stiffRicochet: stiffRicochet_step(); break;
	
		}
	}break;
}

