

resizing = false;
mask_index = spr_roomEditor_highlight_corner;

originalScale = [parent.image_xscale,parent.image_yscale]
originalCoords = [mouse_x,mouse_y]
if canResize{
	searchForClick(enterResizing)
}

function enterResizing(){
	searchForRelease(exitResizing)

	originalScale = [parent.image_xscale,parent.image_yscale]
	originalCoords = [mouse_x,mouse_y]
	changeCoords = [0,0]
	resizing = true;
}
function exitResizing(){
	resizing = false;
	cleanUpSearchForRelease()
}

function destroy(){
	instance_destroy();
}