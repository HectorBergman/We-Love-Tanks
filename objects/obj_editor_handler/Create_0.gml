//Does not handle menus outside of the room being edited

enum editorModes {
	editing,
	testing
}
/*case editorModes.editing:{
	}break;
	case editorModes.testing:{
	}break;
*/
editorMode = editorModes.editing;

function summonEditorObjects(){
	summonObject(obj_editor_pointer);
	summonObject(obj_cam);
	summonObject(obj_editor_itemMenu);
	summonObject(obj_editor_player_standIn, [["x", room_width/2], ["y", room_height/2]]);
}
summonEditorObjects();


function checkForModeSwitchRequest(){
	if obj_inputHandler.space{
		switch (editorMode){
			case editorModes.editing:{
				obj_gameSettingHandler.gameState = gameStates.editorTesting
				SignalSend("editorMode: testing_start")
				editorMode = editorModes.testing;
			}break;
			case editorModes.testing:{
				obj_gameSettingHandler.gameState = gameStates.editorBuilding
				SignalSend("editorMode: editing_start")
				editorMode = editorModes.editing;
				instance_destroy(obj_bullet);
				instance_destroy(obj_item);
				instance_destroy(obj_enemy);
			}break;
		}
		return true;
	}
	return false;
}