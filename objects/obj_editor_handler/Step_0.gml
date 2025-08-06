

switch (menuMode){
	case editorMenuModes.selectingRoom:{
		if obj_inputHandler.escape{
			room_goto(rm_roomTemplate_normal);
			summonEditObj = true;
			menuMode = editorMenuModes.editingRoom;
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