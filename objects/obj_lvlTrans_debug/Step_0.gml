PAUSE
if willTry{
	try{
		getTransitionFunction()
		willTry = false;
	}catch(e){
	}
}
if (place_meeting(x,y,obj_player)){
	if !colliding{
		transitionFunction();
	}
}else{
	colliding = false;
}