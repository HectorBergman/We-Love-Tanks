
switch (state){
	case editorHandlerStates.pickingRoom:{
		for (var i = 1; i < array_length(availableRooms); i++){
			if i == chosenRoom{
				draw_text(20,20+i*60, availableRooms[i]);
			}else{
				draw_text(10,20+i*60, availableRooms[i].roomName);
			}
		}
	}break;
	case editorHandlerStates.inRoom:{
	}break;
}