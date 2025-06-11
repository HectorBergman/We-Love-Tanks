loadRoom();
loadInPreviousObjects();
instancesLoaded = true;
var _room = ds_grid_get(obj_roomHandler.dungeonGrid, currentRoom[0], currentRoom[1])
if !is_undefined(_room){
	_room.visited = true;
	obj_currentRoomHandler.roomDoors = _room.doors
	if instance_number(obj_enemy) == 0 && instance_number(obj_enemySpawner) == 0{
		_room.cleared = true;
	}else{
		_room.cleared = false;
	}
}


