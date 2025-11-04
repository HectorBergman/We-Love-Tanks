draw_self()
if text != ""{
	var toDraw = 0;

	text = "[$eee7e7][scale,1]" + text; 
	toDraw = scribble(text).align(fa_center,fa_middle);
	toDraw.draw(x+sprite_width/2, y+sprite_height/2);
}