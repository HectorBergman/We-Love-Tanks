usedPool = variable_global_get(pool + "Pool");

preRandoms = [];
getPreRandom()
chosenIndex = usePreRandom(preRandoms) mod (array_length(usedPool)-1);
chosenOption = usedPool[chosenIndex]


depth = -200
summoned = false;
switch (obj_handler_gameState.gameState){
	case gameStates.regular:{
		if (obj_handler_room.currentRoom.visited){
			instance_destroy();
	
		}else{
			visible = true;
			sprite_index = spr_smoke
		}
	} break;
	case gameStates.editor:{
		visible = true;
		sprite_index = spr_smoke
	}break;
}