
toggleInRoom()

switch (menuMode){
	case editorMenuModes.selectingRoom:{
		
		var move = obj_inputHandler.moveDownClick-obj_inputHandler.moveUpClick
		roomsPosition = (roomsPosition+move) mod (array_length(searchArray)+1);
		if move != 0{
			
			if roomsPosition < 0{
				roomsPosition += array_length(searchArray)+1;
			}
			updateToDrawArray();
		}
		if menu == noone{
			toggleMenu()
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
	switch (menuMode){
		case editorMenuModes.selectingRoom:{
			if obj_inputHandler.confirm{
				if roomsPosition != 0{
					var chosenRoom = searchArray[roomsPosition-1]
					room_goto(asset_get_index("rm_roomTemplate_" + chosenRoom.roomShape));
				}else{
					room_goto(rm_roomTemplate_normal);
				}
				summonEditObj = true;
				menuMode = editorMenuModes.editingRoom;
				justexited = true;
				if menu != noone{
					toggleMenu()
				}
			}
		}
		break;
		case editorMenuModes.editingRoom:{
			if obj_inputHandler.escape{
				try{ //i messed up by not dereferencing globalMenu upon closing without opening another
					// menu so this is how we do it to save dev time
					globalMenu.close()
				}catch(e){}
				room_goto(rm_editor_menu);
				menuMode = editorMenuModes.selectingRoom;
				justexited = true;
				destroyEditorObjects();
			}
		}
	}	
}
