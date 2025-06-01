
if !global.editorPause{
	visible = false;
	exit;
}
if image_xscale == 0{
	image_xscale = 1;
}
if image_yscale == 0{
	image_yscale = 1;
}
visible = true;
justDropped--

if selected && obj_inputHandler.copy&& !held && obj_roomEditor_dragger.held == noone{
	selected = false;
	destroyCorners();
	var ownEditableCopy = [];
	array_copy(ownEditableCopy,0,ownEditable,0,array_length(ownEditable));
	print(ownEditableCopy);
	var newInst = summonObject(obj_roomEditor_instanceRep, 
	[["x", x+32],["y", y], ["object", object], 
	 ["depth", 4], ["editable",editable],["ownEditable",ownEditableCopy],
	 ["image_xscale", image_xscale],["image_yscale", image_yscale]]);
	newInst.held = false
	newInst.selected = true;
			
	newInst.createCorners();
	obj_roomEditor_dragger.highlighted = newInst;
	
}
if held{
	openDialogue = false;
	var rounded_x = ceil((mouse_x+offset[0])/16)*16;
	var rounded_y = ceil((mouse_y+offset[1])/16)*16;
	x = rounded_x;
	y = rounded_y;

}

if !held && mouse_check_button_pressed(mb_right) && place_meeting(x,y,obj_roomEditor_dragger){

	if openDialogue{
		openDialogue = false;
	}else{
		openDialogue = true;
	}
}