draw_self();
for (var i = 0; i < array_length(editable); i++){
	
	toDraw[i].draw(x+10, y+20*(i+0.5));
}
	/*
	if editable[i][1] != "checkbox"{
		for (var j = 0; j < array_length(editable[i][1]); j++){
			text = "[scale][$eee7e7][scale,1][fnt_coolFont]" + editable[i][1][j]; 
			toDraw = scribble(text)
			toDraw.draw(x+40, y+20*(j+0.5));
		}
	}*/
