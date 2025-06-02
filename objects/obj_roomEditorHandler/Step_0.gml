switch (state){
	case editorHandlerStates.pickingRoom:{
		chosenRoom += obj_inputHandler.pressUp-obj_inputHandler.pressDown;
		if maxRooms != 0{
			chosenRoom = chosenRoom mod maxRooms
		}else{
			chosenRoom = 0;
		}
		if obj_inputHandler.confirm{
			state = editorHandlerStates.inRoom;
			room_goto(rm_roomEditor)
		}
	}break;
	case editorHandlerStates.inRoom:{
		if loadInInstanceReps{
			for (var i = 0; i < array_length(availableRooms[chosenRoom].instances); i++){
				var inst = availableRooms[chosenRoom].instances;
				summonObject(obj_roomEditor_instanceRep, inst[i]);
			}
		}
		inRoomLogic();
	}break;
}