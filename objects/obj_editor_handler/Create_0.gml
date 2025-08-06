//Does not handle menus outside of the room being edited, that changes noW!

fileName = "savedRooms2.sav"
roomsData = noone;
loadAllRoomData();

function loadAllRoomData(){
	roomsData = loadData(fileName);
}
roomsData[array_length(roomsData)] = newRoom()

function newRoom(){
	var r = [{
		roomName : "",
		roomShape : "normal",
		roomType : "standard",
	}, {}];
}
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