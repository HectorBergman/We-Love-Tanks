if action == 3 && obj_handler_gameSetting.gameState == gameStates.editorTesting{
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
				obj_handler_gameSetting.gameState = gameStates.regular;
				global.roomList = loadData("savedRooms2.sav");
				room_goto(rm_startingRoom);
				break;

			case bTypes.test: //menu button to select room to edit
				room_goto(rm_test);
				break;
		
			case bTypes.startNewEditor:
				obj_handler_gameSetting.gameState = gameStates.editorBuilding;
				room_goto(rm_editor_menu);
				summonObject(obj_editor_handler);
				//room_goto(rm_editorRoom_test);
				break;
		}
	}
}else{
	image_index = 0;
}