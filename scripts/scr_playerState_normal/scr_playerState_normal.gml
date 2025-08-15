function playerState_normal(){
	if obj_inputHandler.moveDown || obj_inputHandler.moveUp{
		inputVector[1] = (obj_inputHandler.moveDown-obj_inputHandler.moveUp);
	}else{
		inputVector[1] = 0;
	}
	if obj_inputHandler.moveLeft || obj_inputHandler.moveRight{
		inputVector[0] = (obj_inputHandler.moveRight-obj_inputHandler.moveLeft);
	}else{
		inputVector[0] = 0;
	}
	inputVector = normalizeVector(inputVector);
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