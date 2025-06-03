usedPool = variable_global_get(pool + "Pool");


chosenIndex = irandom(array_length(usedPool)-1)
chosenOption = usedPool[chosenIndex]


depth = -200
summoned = false;
switch (obj_gameSettingHandler.gameState){
	case gameStates.regular:{
		if (ds_grid_get(roomHandler.dungeonGrid, roomHandler.currentRoom[0], roomHandler.currentRoom[1]).visited){
			instance_destroy();
	
		}else{
			visible = true;
			sprite_index = spr_smoke
		}
	} break;
	case gameStates.editorTesting:{
		visible = true;
		sprite_index = spr_smoke
	}break;
}