depth = -200
summoned = false;
if (ds_grid_get(roomHandler.dungeonGrid, roomHandler.currentRoom[0], roomHandler.currentRoom[1]).visited){
	instance_destroy();
	
}else{
	visible = true;
	sprite_index = spr_smoke
}