#macro noDoors [doorValues.closed,doorValues.closed,doorValues.closed,doorValues.closed]

pauseMode = [pM.pauseMenu];
lock = true;
roomDoors = [[1,1,1,1],noDoors,noDoors,noDoors];

_room = noone;
SignalSubscribe(id, "roomEntered: newRoom", findRoom);

function findRoom(){

	_room = ds_grid_get(obj_handler_room.dungeonGrid, obj_handler_room.currentRoom[0], obj_handler_room.currentRoom[1])
	
}
findRoom();