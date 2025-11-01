pauseMode = allPause;
colliding=false;
willTry = true;

transitionFunction = function(){}
function getTransitionFunction(){
	transitionFunction = function(){with obj_handler_level{enterLevel();};instance_destroy();}
	
}
