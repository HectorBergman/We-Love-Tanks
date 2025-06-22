
if !summoned{
	summonObject(obj_boss, [["x", x],["y",y],["bossType",bossType]]);
	summoned = true;
}
instance_destroy();