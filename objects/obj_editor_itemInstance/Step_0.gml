switch (held){
	case true:{
		var rounded_x = ceil((mouse_x+offset[0])/16)*16;
		var rounded_y = ceil((mouse_y+offset[1])/16)*16;
		x = rounded_x;
		y = rounded_y;
	}break;
	case false:{
	}break;
}