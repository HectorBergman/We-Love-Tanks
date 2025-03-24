function enemyState_spotted_cannon(){
	if (parent.wallSeen < 3 && parent.playerSeen){
		image_angle = image_angle mod 360;
		var goalDirection = point_direction(x,y,playerTank.x, playerTank.y) mod 360;
		var turnDirection = 0
		if (goalDirection-image_angle > 180 || (goalDirection-image_angle < 0 && goalDirection-image_angle > -180)){
			turnDirection = -1
		}else{
			turnDirection = 1
		}
		print(turnDirection);
	
		if (is_in_range(image_angle,goalDirection-2, goalDirection+2)){
			parent.state = enemyStates.normal;
		}else{
			image_angle = (image_angle + turnDirection*radtodeg(scanningStep)) mod 360
		}
	
	}else{
		parent.state = enemyStates.scanning;
		stepsTilSwitch = 50;
	} 
}

