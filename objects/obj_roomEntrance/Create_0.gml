print("hiimsnapple");
print(roomNo)
print(obj_roomHandler.enteredRoomNo);
print(obj_roomHandler.enteredDoorNo);
print(entranceDoor);
if (obj_roomHandler.enteredDoorNo+2) mod 4 == entranceDoor && obj_roomHandler.enteredRoomNo == roomNo{
	obj_player.x = x;
	obj_player.y = y;
}