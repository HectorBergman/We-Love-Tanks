loadInPreviousObjects();
loadRoom();
var _room = ds_grid_get(roomHandler.dungeonGrid, currentRoom[0], currentRoom[1])
if !is_undefined(_room){
	_room.visited = true;
	obj_currentRoomHandler.roomDoors = _room.doors
	print(_room.roomID);
	print("----");
	print(ds_map_find_value(roomHandler.allRooms,_room.roomID));
}
print("wevisited");
