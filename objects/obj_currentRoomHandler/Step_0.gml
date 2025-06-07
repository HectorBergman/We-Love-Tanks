PAUSE
if obj_inputHandler.debugUnlockAndKill{
	print("debugunlockandkill");
	lock = false;
	for (var i = 0; i < instance_number(obj_enemy); i++){
		var enemy = instance_find(obj_enemy,0)
		enemy.death()
	}
	var cRoom = ds_grid_get(roomHandler.dungeonGrid, roomHandler.currentRoom[0], roomHandler.currentRoom[1])

	cRoom.cleared = true;
}
if obj_inputHandler.debugUnlock{
	print("debugunlock");
	lock = false;
	ds_grid_get(roomHandler.dungeonGrid, roomHandler.currentRoom[0], roomHandler.currentRoom[1]).cleared  =true;
}

lock = !_room.cleared