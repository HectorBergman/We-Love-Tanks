draw_self()
if text != ""{
	
	drawText = "[$eee7e7][scale," + string(image_xscale/goalScale) +  "]" + text; 
	toDraw = scribble(drawText).align(fa_center,fa_middle);
	toDraw.draw(x, y);
	toDraw.flush()
}