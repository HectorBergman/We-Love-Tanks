pauseMode = allPause;
colliding=false;
active = false
enteredRoomNo = -1;
SignalSubscribe(id,"transitionEnd", function(arg){active = true;})

transitionFunction = function(){}
function getTransitionFunction(){
	//todo: amend
	currentRoom_neighbours_request(function(currentRoom_neighbours){
		if !is_undefined(currentRoom_neighbours[roomNo][doorNo]){
			switch(currentRoom_neighbours[roomNo][doorNo].roomType){
				case "none":{}break;
					
				default:{
					transitionFunction = function(){
						print("transfunc")
						print(obj_player.x,",",obj_player.y)
						print(x,",",y)
						//signal to transitionHandler
						SignalSend("transitionStart", {
							transitionType: transitionTypes.toRoom, 
							transitionStruct : {
								roomNo:roomNo,
								doorNo:doorNo, 
								movementVector: obj_player.movementVector,
								store: true,
								offset: [(obj_player.x-x)*(doorNo mod 2 == 1), 
										 (obj_player.y-y)*(doorNo mod 2 == 0)],
								visitPrev : true
							},
							transitionLengthMult : 1
						})
						instance_destroy();
					}
				}break;
			}
		}
	})
}

