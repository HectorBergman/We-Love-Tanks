function enemyState_scanning_cannon(){
	if !(parent.wallSeen < 3 && parent.playerSeen){
		if stepsTilSwitch > 0{
			image_angle = radtodeg(degtorad(image_angle) + scanningDirection*scanningStep)
		}else{
			scanningDirection = scanningDirection*-1
			image_angle = radtodeg(degtorad(image_angle) + scanningDirection*scanningStep)
			stepsTilSwitch = stepTilSwitchWhole;
		}
		stepsTilSwitch--
	}else{
		parent.state = enemyStates.spotted;
		stepsTilSwitch = 50;
	}
}

