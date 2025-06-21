draw_self()

if lightUp{
	draw_rectangle(x-16,y-16,x+16,y+16,false)
}
/*
// Draw Event
// Convert value to hue (0=red, 120=green, 240=blue)
var hue = lerp(240, 0, (distance - 0) / (15 - 0));
var color = make_color_rgb(0, hue, 0); // Full saturation and value

var text = "[scale][$eee7e7][scale,0.5][#" + string(dec_to_hex(color)) + "]" + string(distance); 
var toDraw = scribble(text).align(fa_center,fa_middle);
toDraw.draw(x, y);

