depth = -200
summoned = false;
switch (obj_gameSettingHandler.gameState){
	case gameStates.regular:{
		if (obj_roomHandler_true.currentRoom.visited){
			instance_destroy();
	
		}
	} break;
	case gameStates.editorTesting:{
	}break;
}