if !(ds_grid_get(roomHandler.dungeonGrid, roomHandler.currentRoom[0], roomHandler.currentRoom[1]).visited){
	summonObject(obj_enemy, [["x", x],["y",y],["enemyType",enemyType]]);
}
instance_destroy();