justDropped--
if held{
	openDialogue = false;
	print("lol");
	var rounded_x = ceil((mouse_x+offset[0])/16)*16;
	var rounded_y = ceil((mouse_y+offset[1])/16)*16;
	x = rounded_x;
	y = rounded_y;
	print(x)
	print(y);
	print(offset[0])
	print(offset[1]);
}

if !held && mouse_check_button_pressed(mb_right) && place_meeting(x,y,obj_roomEditor_dragger){
	print("test");
	if openDialogue{
		openDialogue = false;
	}else{
		print("fucke");
		openDialogue = true;
	}
}