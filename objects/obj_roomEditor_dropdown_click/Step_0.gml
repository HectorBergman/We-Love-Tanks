if !global.editorPause{
	visible = false;
	exit;
}
if place_meeting(x,y,obj_roomEditor_dropdown){
	image_alpha = 0;
}else{
	image_alpha = 1;
}
x = parent.x + xoffset;
y = parent.y + yoffset;
visible = parent.visible;
if place_meeting(x,y,obj_roomEditor_dragger) && visible && image_alpha == 1{
	if mouse_check_button_pressed(mb_left){
		if !opened{
			parent.openNewDropDown(id);
		}else{
			close(noone);
		}
	}
}
