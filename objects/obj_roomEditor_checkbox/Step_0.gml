
x = parent.x + xoffset;
y = parent.y + yoffset;
visible = parent.visible;
image_index = isChecked;
var overShadowed = place_meeting(x,y,obj_roomEditor_dropdown)
if place_meeting(x,y,obj_roomEditor_dragger) && !overShadowed{
	if mouse_check_button_pressed(mb_left){
		if isChecked{
			isChecked = false;
			changeInstanceVal(false);
		}else{
			isChecked = true;
			changeInstanceVal(true);
		}
	}
}
if overShadowed{
	image_alpha = 0.3;
}else{
	image_alpha = 1;
}