function enemyState_spotted_cannon(){
	if (parent.wallSeen < 3 && parent.playerSeen){
		image_angle = image_angle mod 360;
		var goalDirection = point_direction(x,y,playerTank.x, playerTank.y) mod 360;
		var turnDirection = sign(image_angle - goalDirection);
		print(turnDirection);
		if (turnDirection == -1){
			if (image_angle < goalDirection){
				parent.state = enemyStates.normal;
			}else{
				image_angle = (image_angle + turnDirection*radtodeg(scanningStep)) mod 360
			}
		}
		else if (turnDirection == 1){
			if (image_angle > goalDirection){
				parent.state = enemyStates.normal;
			}else{
				image_angle = (image_angle + turnDirection*radtodeg(scanningStep)) mod 360
			}
		}
	}else{
		parent.state = enemyStates.scanning;
		stepsTilSwitch = 50;
	} 
}

