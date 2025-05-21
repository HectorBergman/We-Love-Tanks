_room = ds_grid_get(roomHandler.dungeonGrid, roomHandler.currentRoom[0], roomHandler.currentRoom[1])
roomDoors = _room.doors

print(_room.roomID);
print("----");
print(ds_map_find_value(roomHandler.allRooms,_room.roomID));