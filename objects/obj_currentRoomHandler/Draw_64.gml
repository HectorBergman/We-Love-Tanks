if !is_undefined(_room){
	draw_text(0,0,ds_map_find_value(obj_roomHandler.allRooms,_room.roomID));
	draw_text(30,0,_room.edge);
}else{
	draw_text(0,0,"?");
}