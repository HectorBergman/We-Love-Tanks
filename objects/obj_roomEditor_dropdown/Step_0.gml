if !global.editorPause{
	visible = false;
	exit;
}
visible = true;
if place_meeting(x,y,obj_roomEditor_dragger){
	if last{
		image_index = 3;
	}else{
		image_index = 2;
	}
	if mouse_check_button_pressed(mb_left){
		parent.close(value);
		parent.changeInstanceVal(value);
	}
}else{
	if last{
		image_index = 1;
	}else{
		image_index = 0;
	}
}