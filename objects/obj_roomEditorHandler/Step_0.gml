if spawnSpawner{
	spawnSpawner = false;
	summonObject(obj_roomEditor_handlerSpawner);
}
switch (state){
	case editorHandlerStates.pickingRoom:{
		var input = obj_inputHandler.pressDown-obj_inputHandler.pressUp
		if input == 1 && chosenRoom == maxRooms-1{
			chosenRoom = -1;
		}else if input == -1 && chosenRoom == -1{
			chosenRoom = maxRooms-1
		}else{
			chosenRoom += input
		}
		if maxRooms == 0{
			chosenRoom = -1
		}
		if obj_inputHandler.confirm{
			if chosenRoom == -1{
				state = editorHandlerStates.pickingSize;
			}else{	
				loadInInstanceReps = true;
				state = editorHandlerStates.inRoom;
				room_goto(rm_roomEditor)
				spawnSpawner = true;
			}
		}
	}break;
	case editorHandlerStates.pickingSize:{
		var input = obj_inputHandler.pressDown-obj_inputHandler.pressUp
		if chosenShape == 0 && input == -1{
			chosenShape = array_length(global.roomShapes)-1;
		}else{
			chosenShape = (chosenShape + input) mod array_length(global.roomShapes);
		}
		if obj_inputHandler.confirm{
			
			loadInInstanceReps = true;
			state = editorHandlerStates.inRoom;
			currentShape = global.roomShapes[chosenShape];
			room_goto(rm_roomEditor)
			spawnSpawner = true;
			startShape = input;
		}
	}break;
	case editorHandlerStates.inRoom:{
		if room_get_name(room) != "rm_roomTemplate_" + currentShape{
			room_goto(asset_get_index("rm_roomTemplate_" + currentShape));
			loadInInstanceReps = true;
			spawnSpawner = true;
		}
		if loadInInstanceReps{
			var ignore = false;
			if chosenRoom == -1{
				ignore = true;
				currentShape = global.roomShapes[chosenShape];
				chosenRoom = saveRoom("unnamed","standard","0", currentShape)
			}
			if !ignore{
				currentShape = availableRooms[chosenRoom].roomShape;
				for (var i = 0; i < array_length(availableRooms[chosenRoom].instances); i++){
					var inst = availableRooms[chosenRoom].instances;
					summonObject(obj_roomEditor_instanceRep, inst[i]);
				}
				
			}
			loadInInstanceReps = false;
		}
		inRoomLogic();
		if obj_inputHandler.escape && obj_gameSettingHandler.gameState == gameStates.editorBuilding{
			state = editorHandlerStates.pickingRoom;
			instance_destroy(obj_pathFinderHandler);
			instance_destroy(obj_itemHandler)
			instance_destroy(obj_player);
			instance_destroy(obj_crosshair);
			room_goto(rm_editorMenu);
		}
	}break;
}