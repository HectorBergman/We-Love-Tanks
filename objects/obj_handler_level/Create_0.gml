level = 0;

function enterLevel(){
	with obj_handler_room{
		initiateRoomHandler()
		enterNewRoom(0,0,0,-1);

	}
	with obj_handler_currentRoom{
		findRoom();
	}
	
	room_goto(rm_roomTemplate_normal);
}
