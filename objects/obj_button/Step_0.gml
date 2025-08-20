if action == 3 && obj_gameSettingHandler.gameState == gameStates.editorTesting{
	visible = false;
	exit;
}
visible = true;
try{
	if (!instance_exists(parent)){
		instance_destroy();
	}
}catch(e){
}

var truthStatement = position_meeting(mouse_x, mouse_y, id)
	
if (truthStatement){ //hover over button
	image_index = 1;
	if (mouse_check_button_pressed(mb_left)){
		switch (action) {
			case bTypes.empty:
				break;
		
			case bTypes.startGame: //menu button to start game
				obj_gameSettingHandler.gameState = gameStates.regular;
				global.roomList = loadData("savedRooms2.sav");
				room_goto(rm_startingRoom);
				break;
		
			case bTypes.startEditor: //menu button to go to editor
				obj_gameSettingHandler.gameState = gameStates.editorBuilding;
				room_goto(rm_editorMenu);
				break;
		
			case bTypes.saveEditor: //save button for lvl editor
				var inst = instance_find(obj_roomEditorDialogue_prompt, 0);
				if (inst == noone) {
					summonObject(obj_roomEditorDialogue_prompt, 
					[["x", 40], ["y", 50], ["depth", -190]]);
				} else {
					inst.active = true;
					inst.visible = true;
				}
				break;
		
			case bTypes.idk: //menu button to select room to edit
				break;
		
			case bTypes.startNewEditor:
				obj_gameSettingHandler.gameState = gameStates.editorBuilding;
				room_goto(rm_editor_menu);
				summonObject(obj_editor_handler);
				//room_goto(rm_editorRoom_test);
				break;
			case bTypes.exitShop:
				
				break;
		}
	}
}else{
	image_index = 0;
}