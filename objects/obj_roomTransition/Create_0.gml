pauseMode = allPause;
colliding=false;
willTry = true;

transitionFunction = function(){}
function getTransitionFunction(){
	switch(obj_currentRoomHandler.roomDoors[roomNo][doorNo]){
		case doorValues.open:{
			transitionFunction = function(){
				//signal to transitionHandler
				SignalSend("transitionStart", {
					transitionType: transitionTypes.toRoom, 
					transitionArr :[xDiff,yDiff,roomNo,doorNo, obj_player.movementVector]
				})
				instance_destroy();
			}
		}break;
		case doorValues.openToNewStage:{
			transitionFunction = function(){with obj_levelHandler{enterLevel();};instance_destroy();}
		}break;
		case doorValues.openToShop:{
			transitionFunction = function(){
				SignalSend("transitionStart", {
					transitionType: transitionTypes.toShop, 
					transitionArr :[xDiff,yDiff,roomNo,doorNo]
				})
				instance_destroy();
			}
		}break;
	}
}
