#macro noDoors [0,0,0,0]
pauseMode = pM.pauseMenu;
lock = true;
roomDoors = [[1,1,1,1],noDoors,noDoors,noDoors];

_room = noone;

function findRoom(){
	if _room == noone || is_undefined(_room){
		print("helloed");
		_room = ds_grid_get(obj_roomHandler.dungeonGrid, obj_roomHandler.currentRoom[0], obj_roomHandler.currentRoom[1])
	}
}
findRoom();