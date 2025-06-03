
if !global.editorPause{
	visible = false;
	exit;
}
for (var i = 0; i < array_length(editable); i++){
	if editable[i][0] != ""{
		text[i] = "[$eee7e7][scale,1][fnt_coolFont]" + editable[i][0]; 
		toDraw[i] = scribble(text[i])
		if toDraw[i].get_width() > largestWidth{
			largestWidth = toDraw[i].get_width();
		}
	}else if editable[i][0] == ""{
		text[i] = "[$eee7e7][scale,1][fnt_coolFont]" + ownEditable[i]; 
		toDraw[i] = scribble(text[i])
		if toDraw[i].get_width() > largestWidth{
			largestWidth = toDraw[i].get_width();
		}
	}
}



if active{
	totalWidth = largestWidth+20+10+sprite_get_width(object_get_sprite(obj_roomEditor_dropdown_click))+5+longestLongestLength;
	image_xscale = totalWidth/spriteWidth;

	visible = true;

	mask_index = spr_roomEditor_menu_edit_Xhitbox
	if place_meeting(x,y,obj_roomEditor_dragger){
		if mouse_check_button_pressed(mb_left){
			active = false;
			visible = false;
		}
	}
	mask_index = originalMask
}
