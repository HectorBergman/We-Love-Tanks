if floor(image_index) == 5 && !summoned{
	summonObject(obj_enemy, [["x", x],["y",y],["enemyType",enemyType]]);
	summoned = true;
}
if floor(image_index) == 11{
	instance_destroy();
}