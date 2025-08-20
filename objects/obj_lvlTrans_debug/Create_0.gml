pauseMode = allPause;
colliding=false;
willTry = true;

transitionFunction = function(){}
function getTransitionFunction(){
	transitionFunction = function(){with obj_levelHandler{enterLevel();};instance_destroy();}
	
}
