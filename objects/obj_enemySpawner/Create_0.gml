depth = -200
summoned = false;
switch (obj_handler_gameSetting.gameState){
	case gameStates.regular:{
		if (obj_handler_room.currentRoom.visited){
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