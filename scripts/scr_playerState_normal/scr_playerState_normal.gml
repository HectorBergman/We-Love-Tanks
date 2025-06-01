function playerState_normal(){
	if obj_inputHandler.moveDown || obj_inputHandler.moveUp{
		movementVector[1] = (obj_inputHandler.moveDown-obj_inputHandler.moveUp);
	}else{
		movementVector[1] = 0;
	}
	if obj_inputHandler.moveLeft || obj_inputHandler.moveRight{
		movementVector[0] = (obj_inputHandler.moveRight-obj_inputHandler.moveLeft);
	}else{
		movementVector[0] = 0;
	}
	movementVector = normalizeVector(movementVector);
}

function normalizeVector(vector){
	var pythagoras = sqrt(power(abs(vector[0]), 2)+power(abs(vector[1]), 2))
	if pythagoras != 0{
		var normalize = 1/pythagoras
	
		vector[0] *= normalize;
		vector[1] *= normalize;
	}
	return vector;
}