switch (state){
	case editorHandlerStates.pickingRoom:{
		print(obj_inputHandler.pressUp-obj_inputHandler.pressDown)
		var input = obj_inputHandler.pressDown-obj_inputHandler.pressUp
		if input == 1 && chosenRoom == maxRooms-1{
			chosenRoom = -1;
		}else if input == -1 && chosenRoom == -1{
			chosenRoom = maxRooms-1
		}else{
			chosenRoom += input
		}
		if maxRooms == 0{
			chosenRoom = -1
		}
		if obj_inputHandler.confirm{
			loadInInstanceReps = true;
			state = editorHandlerStates.inRoom;
			room_goto(rm_roomEditor)
		}
	}break;
	case editorHandlerStates.inRoom:{
		if loadInInstanceReps{
			var ignore = false;
			if chosenRoom == -1{
				ignore = true;
			}
			print(availableRooms);
			if !ignore{
				
				for (var i = 0; i < array_length(availableRooms[chosenRoom].instances); i++){
					var inst = availableRooms[chosenRoom].instances;
					print(inst[i]);
					summonObject(obj_roomEditor_instanceRep, inst[i]);
				}
			}
			loadInInstanceReps = false;
		}
		inRoomLogic();
	}break;
}