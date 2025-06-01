if action == 3 && obj_gameSettingHandler.gameState == gameStates.editorTesting{
	visible = false;
	exit;
}
visible = true;
try{
	if (!instance_exists(parent)){
		instance_destroy();
	}
}catch(e){
}
var truthStatement = position_meeting(mouse_x, mouse_y, id)
	
if (truthStatement){ //hover over button
	image_index = 1;
	if (mouse_check_button_pressed(mb_left)){
		if (action == 0){ 
		}else if action == 1{
			obj_gameSettingHandler.gameState = gameStates.regular
			room_goto(rm_startingRoom)
		}else if action == 2{
			obj_gameSettingHandler.gameState = gameStates.editorBuilding
			room_goto(rm_roomEditor)
		}else if action == 3{
			obj_roomEditorHandler.saveRoom();
		}
	}
}else{
	image_index = 0;
}