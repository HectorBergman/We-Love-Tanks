function playerMovement_state(){
	movementState_x = movementStates.nothing
	movementState_y = movementStates.nothing
	if listenForInput("left") || listenForInput("right"){
		if listenForInput("run"){
			movementState_x = movementStates.run
		}else{
			movementState_x = movementStates.walk
		}
	}
	if listenForInput("up") || listenForInput("down"){
		if listenForInput("run"){
			movementState_y = movementStates.run
		}else{
			movementState_y = movementStates.walk
		}
	}
	var movementState_xy = [movementState_x, movementState_y]
	var moveSpeed = [horizontalMoveSpeed,verticalMoveSpeed]
	for (var i = 0; i < 2; i++){
		switch (movementState_xy[i]){
			case movementStates.run:{
				var diff = regularSpeed*movementVector[i]-moveSpeed[i]
				if sign(moveSpeed[i]) != sign(movementVector[i]) ||
					abs(moveSpeed[i]) < abs(runSpeed*movementVector[i]){
					moveSpeed[i] += runSpeedStep*movementVector[i]*sqrt(abs(diff))
				}
			}break;
			case movementStates.walk:{
					
				var diff = regularSpeed*movementVector[i]-moveSpeed[i]
				if sign(moveSpeed[i]) != sign(movementVector[i]) ||
					abs(moveSpeed[i]) < abs(regularSpeed*movementVector[i]){
					moveSpeed[i] += 0.1*movementVector[i]*sqrt(abs(diff))
				}
					
			}break;
			case movementStates.nothing:{
				if (abs(moveSpeed[i]) <= 0.2) {
			        moveSpeed[i] = 0;
			    } else if (abs(moveSpeed[i]) < 1.0) {
			        moveSpeed[i] *= 0.8; //for making smaller adjustments
			    } else {
			        moveSpeed[i] *= 0.95;
			    }
    break;
			}
		}
	}
	horizontalMoveSpeed = moveSpeed[0]
	verticalMoveSpeed = moveSpeed[1];
}

function calculateVector(movementVector, trueMovementVector, inputVector, turn_speed){
	switch (state){
	    case playerStates.normal: playerState_normal(); break;
	}
	switch turnState{
		case turnStates.normal:{
		}break;
		case turnStates.turn:{
		}break;
			
	}
	movementVector = inputVector;
	var angle = hitbox.image_angle
	var goal = point_direction(0,0,movementVector[0],movementVector[1])
	if abs(angle_difference(angle, goal)) > 135+5{
	}else if abs(angle_difference(angle, goal)) < 0.2{
		hitbox.image_angle = goal;
	}else{
		var rot_stiffness = 10
		var rot_damp_coeff = 50;
		var diff = angle_difference(goal, angle);
		var accel = diff * rot_stiffness*(1/60);

		rot_vel += accel;
		rot_vel *= exp(-rot_damp_coeff*(1/60));
		if abs(diff) < 2{
			hitbox.image_angle = goal
		}else{
			hitbox.image_angle += rot_vel
		}
	}
	return movementVector;
}





		




