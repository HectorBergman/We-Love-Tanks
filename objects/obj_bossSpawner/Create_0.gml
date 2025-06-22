depth = -200
summoned = false;
switch (obj_gameSettingHandler.gameState){
	case gameStates.regular:{
		if (ds_grid_get(obj_roomHandler.dungeonGrid, obj_roomHandler.currentRoom[0], obj_roomHandler.currentRoom[1]).visited){
			instance_destroy();
	
		}
	} break;
	case gameStates.editorTesting:{
	}break;
}