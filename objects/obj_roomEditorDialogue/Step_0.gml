visible = parent.openDialogue
x = parent.x + parent.sprite_width + 32;
y = parent.y - 32
mask_index = spr_roomEditor_menu_edit_Xhitbox
if place_meeting(x,y,obj_roomEditor_dragger){
	if mouse_check_button_pressed(mb_left){
		parent.openDialogue = false;
	}
}
mask_index = originalMask