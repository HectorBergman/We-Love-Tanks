function playerState_normal(){
	if listenForInput("down") || listenForInput("up"){
		inputVector[1] = (listenForInput("down")-listenForInput("up"));
	}else{
		inputVector[1] = 0;
	}
	if listenForInput("left") || listenForInput("right"){
		inputVector[0] = (listenForInput("right")-listenForInput("left"));
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