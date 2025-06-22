colliding=false;
print("door:")
try{
	
	print(obj_currentRoomHandler.roomDoors[roomNo][doorNo])
	if obj_currentRoomHandler.roomDoors[roomNo][doorNo] == 2{
		print("TRANSFORM!");
		instance_change(obj_levelTransition, true);
	}
}catch(e){print("fail");}