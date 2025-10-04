pauseMode = allPause;
colliding=false;
active = false
SignalSubscribe(id,"transitionEnd", function(arg){active = true;})

transitionFunction = function(){}
function getTransitionFunction(){
	//todo: amend
	switch(obj_roomHandler_true.currentRoom.doors[doorNo]){//roomDoors[roomNo][doorNo]){
		case doorValues.open:{
			transitionFunction = function(){
				//signal to transitionHandler
				SignalSend("transitionStart", {
					transitionType: transitionTypes.toRoom, 
					transitionStruct : {
						diff: [xDiff,yDiff],
						roomNo:roomNo,
						doorNo:doorNo, 
						movementVector: obj_player.movementVector,
						store: true
					},
					transitionLengthMult : 1
				})
				instance_destroy();
			}
		}break;
		case doorValues.openToNewStage:{
			transitionFunction = function(){with obj_levelHandler{enterLevel();};instance_destroy();}
		}break;
	}
}
try{
	getTransitionFunction()
}catch(e){
	SignalSubscribe(id, "getTransitionFunction", getTransitionFunction)
}
