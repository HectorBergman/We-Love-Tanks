if instance_exists(obj_currentRoomHandler){
	if obj_roomHandler.enterInfo.enteredRoomDoor == -1{
		obj_player.x = 960/2
		obj_player.y = 540/2
	}else if (obj_roomHandler.enterInfo.enteredRoomDoor+2) mod 4 == entranceDoor && obj_roomHandler.enterInfo.enteredRoomNo == roomNo{
		obj_player.x = x;
		obj_player.y = y;
	}
}