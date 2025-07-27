if isLast{
	image_index = 1;
}else{
	image_index = 0;
}
if place_meeting(x,y,obj_editor_pointer){
	image_index += 2;
	//todo: replace this so its handeled as a signal in editor pointer instead
	if obj_inputHandler.click{
		updateInstance();
	}
}