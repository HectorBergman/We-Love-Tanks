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
		if (action == 0){ 
		}else if action == 1{//menu button to start game
			obj_gameSettingHandler.gameState = gameStates.regular
			global.roomList = loadData("savedRooms.sav");
			room_goto(rm_startingRoom)
		}else if action == 2{//menu button to go to editor
			obj_gameSettingHandler.gameState = gameStates.editorBuilding
			room_goto(rm_editorMenu)
		}else if action == 3{ //save button for lvl editor
			var inst = instance_find(obj_roomEditorDialogue_prompt,0)
			if inst == noone{
				summonObject(obj_roomEditorDialogue_prompt,[["x", 40],["y",50], ["depth", -190]]);
			}else{
				inst.active = true;
				inst.visible = true;
			}
			
		}else if action == 4{ //menu button to select room to edit
		}else if action == 5{
			obj_gameSettingHandler.gameState = gameStates.editorBuilding
			room_goto(rm_editor_menu);
			//room_goto(rm_editorRoom_test);
		}
	}
}else{
	image_index = 0;
}