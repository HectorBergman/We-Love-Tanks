if !is_undefined(_room){
	draw_text(0,0,ds_map_find_value(roomHandler.allRooms,_room.roomID));
}else{
	draw_text(0,0,"?");
}