
if keyboard_check_pressed(ord("K")) || keyboard_check(ord("J")){
	print(dungeon.floors[0]);
	regenDfloor(dungeon.floors[0].floorNo);
}