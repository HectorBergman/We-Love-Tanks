pauseMode = allPause;
colliding=false;
active = false
enteredRoomNo = -1;
SignalSubscribe(id,"transitionEnd", function(arg){active = true;})

transitionFunction = function(){}
function getTransitionFunction(){
	//todo: amend
	SignalSubscribe(id, "currentRoom_doors_request_response", function(currentRoom_doors){
		switch(currentRoom_doors[roomNo][doorNo]){
			case doorValues.open:{
				transitionFunction = function(){
					//signal to transitionHandler
					SignalSend("transitionStart", {
						transitionType: transitionTypes.toRoom, 
						transitionStruct : {
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
	})
	SignalSend("currentRoom_doors_request");
	SignalUnsubscribe(id, "currentRoom_doors_request_response");
}
