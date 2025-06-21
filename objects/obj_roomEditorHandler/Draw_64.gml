draw_text(50,50,chosenRoom);
switch (state){
	case editorHandlerStates.pickingRoom:{
		for (var i = -1; i < array_length(availableRooms); i++){
			if i == chosenRoom{
				if i == -1{
					draw_text(20,80+i*60,"NEW");
				}else{
					draw_text(20,80+i*60, string(availableRooms[i].roomName) + " Type: " + string(availableRooms[i].type) + " Shape: " + string(availableRooms[i].roomShape) + " Difficulty: " + string(availableRooms[i].difficulty));
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
	case editorHandlerStates.deleteAreYouSure:{
		for (var i = -1; i < array_length(availableRooms); i++){
			if i == chosenRoom{
				if i == -1{
					draw_text(20,80+i*60,"NEW");
				}else{
					draw_text(20,80+i*60, string(availableRooms[i].roomName) + " Type: " + string(availableRooms[i].type) + " Shape: " + string(availableRooms[i].roomShape) + " Difficulty: " + string(availableRooms[i].difficulty));
				}
				draw_text(300,80+i*60+80, "Are you sure you want to delete room?\nPress del again to confirm\nPress any other key to cancel.")
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
	case editorHandlerStates.pickingSize:{
		for (var i = 0; i < array_length(global.roomShapes); i++){
			if i == chosenShape{
				draw_text(20,80+i*60, global.roomShapes[i]);
			}else{
				draw_text(10,80+i*60, global.roomShapes[i]);
			}
		}
	}break;
}