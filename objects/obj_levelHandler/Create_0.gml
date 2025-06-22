level = 0;

function enterLevel(){
	with obj_roomHandler{
		initiateRoomHandler()
	}
	room_goto(rm_roomTemplate_normal);
}
