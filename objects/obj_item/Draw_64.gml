var text = "";
var toDraw = 0;
switch (state){
	case itemState.collected:{
		text = "[scale][$eee7e7][scale,2][alpha," + string(textAlpha) + "]" + pickupText; 
		toDraw = scribble(text).align(fa_center,fa_middle);
		toDraw.draw(960, textY);
	}
}