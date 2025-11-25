function playerState_normal(){
	var testVec = [0,0]
	if listenForInput("down") || listenForInput("up"){
		testVec[1] = (listenForInput("down")-listenForInput("up"));
	}
	if listenForInput("left") || listenForInput("right"){
		testVec[0] = (listenForInput("right")-listenForInput("left"));
	}
	var test = point_direction(0, 0, testVec[0], testVec[1])
	if point_distance(0,0,testVec[0],testVec[1]) > 0{
		inputVector = [lengthdir_x(1,test), lengthdir_y(1,test)]
	}
	
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