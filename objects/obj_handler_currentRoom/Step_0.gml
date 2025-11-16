PAUSE
if listenForInput("unlock_and_kill"){
	print("debugunlockandkill");
	lock = false;
	for (var i = 0; i < instance_number(obj_enemy); i++){
		var enemy = instance_find(obj_enemy,0)
		enemy.death()
	}
	var cRoom = ds_grid_get(obj_handler_room.dungeonGrid, obj_handler_room.currentRoom[0], obj_handler_room.currentRoom[1])

	cRoom.cleared = true;
}
if listenForInput("unlock"){
	print("debugunlock");
	lock = false;
	ds_grid_get(obj_handler_room.dungeonGrid, obj_handler_room.currentRoom[0], obj_handler_room.currentRoom[1]).cleared  =true;
}

lock = !_room.cleared
//fixxxx