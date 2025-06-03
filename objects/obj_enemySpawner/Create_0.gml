depth = -200
summoned = false;
switch (obj_gameSettingHandler.gameState){
	case gameStates.regular:{
		if (ds_grid_get(roomHandler.dungeonGrid, roomHandler.currentRoom[0], roomHandler.currentRoom[1]).visited){
			print("fucked");
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