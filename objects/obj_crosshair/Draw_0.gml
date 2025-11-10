draw_self();

var text = "";
var toDraw = 0;

text = "[$eee7e7][scale,1][alpha,1]" + string(x) + "," + string(y); 
toDraw = scribble(text).align(fa_center,fa_middle);
toDraw.draw(x+30, y+30);
toDraw.flush();