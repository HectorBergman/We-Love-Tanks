
fileName = "savedRooms2.sav"
roomsPosition = 0;
roomsData = [];
toDrawArray = [];
justexited = false;
SignalSubscribe(id, "saved room", function(arg){ saveRoom(arg)})
loadAllRoomData();
function updateToDrawArray(){
	toDrawArray = [];
	var text = ""
	var roomsDataLen = array_length(roomsData);
	for (var i = roomsPosition; i < roomsPosition+5; i++){
		if i == 0{
			text = "[$eee7e7][scale,1][fnt_coolFont]NEW"
		}else if (i-1) < roomsDataLen{
			text = "[$eee7e7][scale,1][fnt_coolFont]" + roomsData[i-1].roomName;
		}else{
			break;
		}
		toDrawArray[i-roomsPosition] = scribble(text);
	}
}
updateToDrawArray();
enum editorMenuModes {
	selectingRoom,
	editingRoom,
}
enum editorModes {
	editing,
	testing
}
/*case editorModes.editing:{
	}break;
	case editorModes.testing:{
	}break;
*/
summonEditObj = false;
editorMode = editorModes.editing;
menuMode = editorMenuModes.selectingRoom;
function summonMenuObjects(){
	summonObject(obj_editor_pointer);
}
function summonEditorObjects(){
	summonObject(obj_cam);
	summonObject(obj_editor_itemMenu);
	summonObject(obj_editor_player_standIn, [["x", room_width/2], ["y", room_height/2]]);
	summonObject(obj_editor_saveRoomButton, [["x", 0],["y", 0]]);
}

function destroyEditorObjects(){
	instance_destroy(obj_cam);
	instance_destroy(obj_editor_itemMenu);
	instance_destroy(obj_editor_player_standIn);
	instance_destroy(obj_editor_saveRoomButton);
	instance_destroy(obj_editor_itemInstance);
}

summonMenuObjects();


function checkForModeSwitchRequest(){
	if obj_inputHandler.space{
		switch (editorMode){
			case editorModes.editing:{
				obj_gameSettingHandler.gameState = gameStates.editorTesting
				SignalSend("editorMode: testing_start")
				SignalSend("itemInstance: unhighlight");
				editorMode = editorModes.testing;
			}break;
			case editorModes.testing:{
				obj_gameSettingHandler.gameState = gameStates.editorBuilding
				SignalSend("editorMode: editing_start")
				editorMode = editorModes.editing;
				instance_destroy(obj_bullet);
				instance_destroy(obj_item);
				instance_destroy(obj_enemy);
				instance_destroy(obj_dollar);
			}break;
		}
		return true;
	}
	return false;
}

function editingRoomLogic(){
	switch (editorMode){
		case editorModes.editing:{
		
		}break;
		case editorModes.testing:{
		
		}break;
	}
}

