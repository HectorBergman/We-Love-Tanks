x = parent.x + xoffset;
y = parent.y + yoffset;
visible = parent.visible;
if place_meeting(x,y,obj_roomEditor_dragger) && visible{
	if mouse_check_button_pressed(mb_left){
		parent.openNewDropDown(id);
	}
}