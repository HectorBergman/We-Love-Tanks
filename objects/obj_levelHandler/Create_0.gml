level = 0;

function enterLevel(){
		
	SignalSend("new level");	
	with obj_roomHandler{
		initiateRoomHandler()
		enterNewRoom(0,0,0,-1);

	}
	with obj_currentRoomHandler{
		findRoom();
	}
	
	room_goto(rm_roomTemplate_normal);
}
