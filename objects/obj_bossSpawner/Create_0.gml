depth = -200
summoned = false;
switch (obj_handler_gameState.gameState){
	case gameStates.regular:{
		if (obj_handler_room.currentRoom.visited){
			instance_destroy();
	
		}
	} break;
	case gameStates.editor:{
	}break;
}