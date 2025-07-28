draw_self();

switch (type){
	case "options":{
		var text = "[$eee7e7][scale,1][fnt_coolFont]" + argumentChoice; 
	var toDraw = scribble(text)
	toDraw.draw(x+2,y);
	}break;
	case "checkbox":{
	}break;
	case "freeText":{
		var val = buffer;
		var text = "[$eee7e7][scale,1][fnt_coolFont][alpha," + string(image_alpha) + "]" + val; 
		var toDraw = scribble(text)

		toDraw.draw(x+2, y);
	}break;
}
