function playerMovement_state(){
	movementState = movementStates.nothing
	if listenForInput("up") || listenForInput("down") || listenForInput("left") || listenForInput("right"){
		if listenForInput("run"){
			movementState = movementStates.run
		}else{
			movementState = movementStates.walk
		}
	}
	switch (movementState){
		case movementStates.run:{
			if movementSpeed < runSpeed{
				movementSpeed += runSpeedStep*ts
			}else{
				movementSpeed = runSpeed;
			}
		}break;
		case movementStates.walk:{
			if movementSpeed > regularSpeed{
				movementSpeed -= runSpeedStep*ts
			}else if inRange(movementSpeed, regularSpeed-0.05*ts, regularSpeed + 0.05*ts){
				movementSpeed = regularSpeed;
			}else{
				movementSpeed += runSpeedStep*0.5*ts
			}
		}break;
		case movementStates.nothing:{
			if inRange(movementSpeed, -0.1,0.1*ts){
				movementSpeed = 0
			}else if movementSpeed > 0{
				movementSpeed -= runSpeedStep*0.5*ts
			}else{
				movementSpeed += runSpeedStep*0.5*ts
			}
		}
	}
	switch turnState{
		case turnStates.turn:
			movementSpeed *= 0.9*(1/ts)
			break;
	}
}

function calculateVector(movementVector, trueMovementVector, inputVector, turn_speed){
	switch (state){
	    case playerStates.normal: playerState_normal(); break;
	}
	
	diffArr = [inputVector[0] - trueMovementVector[0],
			   inputVector[1] - trueMovementVector[1]]


	for (var i = 0; i < 2; i++){
		if abs(diffArr[i]) < 0.05{
			trueMovementVector[i] = inputVector[i]
			turnState = turnStates.normal;
		}else{
			trueMovementVector[i] += sign(diffArr[i])*turn_speed
			turnState = turnStates.turn;
		}
	}
	print(trueMovementVector)
	print(inputVector)
	print("---")
	var dir = point_direction(0,0,trueMovementVector[0],trueMovementVector[1])
	movementVector = [lengthdir_x(1, dir), lengthdir_y(1, dir)];
	print(movementVector)

	hitbox.image_angle = point_direction(0,0,movementVector[0],movementVector[1]);
	return movementVector;
	/*if abs(inputVector[0]-fakeMovementVec[0]) < 0.05{
		fakeMovementVec[0] = inputVector[0]
	}else{
		fakeMovementVec[0] += sign(fakeMovementVec[0]-fakeMovementVec[0])*movementVectorStep
	}
	if abs(inputVector[1]-fakeMovementVec[1]) < 0.05{
		fakeMovementVec[1] = inputVector[1]
	}else{
		fakeMovementVec[1] += sign(inputVector[1]-fakeMovementVec[1])*movementVectorStep
	}
	if (fakeMovementVec[0] != 0 || fakeMovementVec[1] != 0){
		if wallBonkCooldown == 0{
			var goalAngle = point_direction(x,y,x + fakeMovementVec[0], y + fakeMovementVec[1])
			hitbox.image_angle = gradualPoint(goalAngle, hitbox.image_angle, turningSpeed);
			angle = hitbox.image_angle
		}else{
			wallBonkCooldown--
		}
	}
	var goalAngle = point_direction(x,y,x + fakeMovementVec[0], y + fakeMovementVec[1])
	movementVector = [dsin(goalAngle), dcos(goalAngle)]
	return movementVector*/
}





		




