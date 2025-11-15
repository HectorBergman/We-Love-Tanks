isActive = (
	obj_handler_gameState.gameState == gameStates.editor && 
	obj_handler_gameState.editorState == editorStates.building) ||
	obj_handler_gameState.menuState == menuStates.active

switch(isActive){
	case true:{
		visible = true
		x = mouse_x;
		y = mouse_y;
		if obj_handler_input.fire{
			image_index = 1;
		}else{
			image_index = 0;
		}
		clickingLogic();

	}break;
	case false:{
		visible = false;
	}break;
}
