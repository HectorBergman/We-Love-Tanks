if !global.editorPause{
	visible = false;
	exit;
}
visible = true;
x = parent.x + xoffset;
y = parent.y + yoffset;
visible = parent.visible;
image_index = state;
switch (state){
	case typerStates.active:{
		if !place_meeting(x,y,obj_roomEditor_dragger) && visible{
			if mouse_check_button_pressed(mb_left){
				state = typerStates.inactive
			}
		}
		
		var _key = keyboard_lastchar;
		print(_key);
		print(string_upper(_key));
		print(keyboard_check_pressed(ord(string_upper(_key))));
		if keyboard_check_pressed(vk_backspace){
			buffer = string_delete(buffer,string_length(buffer),1);
		}else{
			if keyboard_check_pressed(ord(string_upper(_key))){
				buffer += _key;
				changeInstanceVal(buffer)
			}
		}
	}break;
	case typerStates.inactive:{
		if place_meeting(x,y,obj_roomEditor_dragger) && visible{
			if mouse_check_button_pressed(mb_left){
				state = typerStates.active
				
			}
		}
	}break;
}
/*if place_meeting(x,y,obj_roomEditor_dragger) && visible{
	if mouse_check_button_pressed(mb_left){
		if !opened{
			parent.openNewDropDown(id);
		}else{
			close(noone);
		}
	}
}
