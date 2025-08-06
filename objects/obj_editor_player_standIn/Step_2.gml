if held{
	var rounded_x = ceil((mouse_x+offset[0])/16)*16;
	var rounded_y = ceil((mouse_y+offset[1])/16)*16;
	x = rounded_x;
	y = rounded_y;
}
if !held && place_meeting(x,y,obj_wall) || !inRange(x, 0, room_width) || !inRange(y, 0, room_height){
		x = room_width/2;
		y = room_height/2;
}