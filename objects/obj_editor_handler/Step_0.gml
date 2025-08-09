
toggleInRoom()

switch (menuMode){
	case editorMenuModes.selectingRoom:{
		
		var move = obj_inputHandler.moveDownClick-obj_inputHandler.moveUpClick
		if move != 0{
			roomsPosition = (roomsPosition+move) mod (array_length(roomsData)+1);
			if roomsPosition < 0{
				roomsPosition += array_length(roomsData)+1;
			}
			updateToDrawArray();
			print(roomsPosition);
		}
	}break;
	case editorMenuModes.editingRoom:{
		if checkForModeSwitchRequest(){
			exit; //delete this maybe if it causes iffy edge cases with missed step events
			//(ends this step if its the frame we switch editormodes
		}
		editingRoomLogic()
	}break;
}

function toggleInRoom(){
	if obj_inputHandler.escape && !justexited{
		switch (menuMode){
			case editorMenuModes.selectingRoom:{
				room_goto(rm_roomTemplate_normal);
				summonEditObj = true;
				menuMode = editorMenuModes.editingRoom;
				justexited = true;
			}
			break;
			case editorMenuModes.editingRoom:{
				room_goto(rm_editor_menu);
				menuMode = editorMenuModes.selectingRoom;
				justexited = true;
				destroyEditorObjects();
			}
		}
		obj_inputHandler.escape = false;
	}
}