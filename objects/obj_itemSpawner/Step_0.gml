
if floor(image_index) == 5 && !summoned{
	summonObject(obj_item,[["itemId", chosenOption.itemId], ["x",x],["y",y]]);
	summoned = true;
}
if floor(image_index) == 11{
	instance_destroy();
}

