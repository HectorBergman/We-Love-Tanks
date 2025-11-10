display_set_gui_size(camWidth, camHeight);
switch (obj_handler_handler.gameState){
	case gameStates.editor:{
		switch (obj_handler_handler.editorState){
			case (editorStates.building):{
				x = x + (obj_handler_input.moveRight-obj_handler_input.moveLeft)*4
				y = y + (obj_handler_input.moveDown-obj_handler_input.moveUp)*4
				x = clamp(x,camWidth*0.5,room_width-(camWidth*0.5));
				y = clamp(y,camHeight*0.5,room_height-(camHeight*0.5));
				newX = clamp(x-(camWidth*0.5),0,room_width-(camWidth));
				newY = clamp(y-(camHeight*0.5),0,room_height-(camHeight));
				camera_set_view_pos(view_camera[0],newX,newY);
			}break;
			case (editorStates.testing):{}
		}
	}break;
	case gameStates.regular:{
		if point_distance(obj_player.x, 0, obj_crosshair.x, 0) > minDistForLerpX{
			x = obj_player.x + (lerp(obj_player.x,obj_crosshair.x,pointerBodyRatio) 
			  - obj_player.x+sign(obj_player.x-obj_crosshair.x)*(minDistForLerpX*pointerBodyRatio))
		}else{
			x = obj_player.x
		}

		if point_distance(0, obj_player.y, 0, obj_crosshair.y) > minDistForLerpY{
	
			y = obj_player.y + (lerp(obj_player.y,obj_crosshair.y,pointerBodyRatio) 
			  - obj_player.y+sign(obj_player.y-obj_crosshair.y)*(minDistForLerpY*pointerBodyRatio))
		}else{

			y = obj_player.y
		}

		newX = clamp(x-(camWidth*0.5),0,room_width-(camWidth));
		newY = clamp(y-(camHeight*0.5),0,room_height-(camHeight));


		camera_set_view_pos(view_camera[0],newX,newY);
	}break;
}
