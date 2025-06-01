if !global.editorPause{
	visible = false;
	exit;
}
visible = true;
if held{
	openDialogue = false;
	var rounded_x = ceil((mouse_x+offset[0])/16)*16;
	var rounded_y = ceil((mouse_y+offset[1])/16)*16;
	x = rounded_x;
	y = rounded_y;

}

if !held && mouse_check_button(mb_left){
	if openDialogue{
		openDialogue = false;
	}else{
		openDialogue = true;
	}
}