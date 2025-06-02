draw_text(50,50,chosenRoom);
switch (state){
	case editorHandlerStates.pickingRoom:{
		for (var i = -1; i < array_length(availableRooms); i++){
			if i == chosenRoom{
				if i == -1{
					draw_text(20,80+i*60,"NEW");
				}else{
					draw_text(20,80+i*60, availableRooms[i]);
				}
			}else{
				if i == -1{
					draw_text(10,80+i*60,"NEW");
				}else{
					draw_text(10,80+i*60, availableRooms[i].roomName);
				}
			}
		
		}
	}break;
	case editorHandlerStates.inRoom:{
	}break;
}