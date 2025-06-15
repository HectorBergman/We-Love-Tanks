draw_self();
if place_meeting(x,y,obj_roomEditor_dragger){
	var text = "[scale][$eee7e7][scale,1]" + _name; 
	var toDraw = scribble(text).align(fa_center,fa_middle);
	toDraw.draw(x+16, y);
}