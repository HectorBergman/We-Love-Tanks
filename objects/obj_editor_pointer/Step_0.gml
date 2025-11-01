switch(isActive){
	case true:{
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
	}break;
}
