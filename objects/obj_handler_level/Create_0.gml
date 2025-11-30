level = 0;

function enterLevel(){
	print("jaja");
	with obj_handler_room{
		print("testpenis");
		initiateRoomHandler()
		enterNewRoom(0,0,0,-1);

	}
	with obj_handler_currentRoom{
		findRoom();
	}
	
	room_goto(rm_roomTemplate_normal);
}
