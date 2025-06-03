if !global.editorPause{
	visible = false;
	exit;
}
visible = true;
x = parent.x + xoffset;
y = parent.y + yoffset;
visible = parent.visible;

//image_index = state;
if place_meeting(x,y,obj_roomEditor_dragger) && visible{
	if mouse_check_button_pressed(mb_left){
		parent.saveRoom();
		parent.close();
	}
}