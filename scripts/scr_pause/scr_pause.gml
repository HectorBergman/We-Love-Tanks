function pause(mode) {
	var paused = false;
	for (var i = 0; i < array_length(mode); i++){
		var pauseRestriction = mode[i];
		switch (pauseRestriction){
			case pM.editor: paused = global.editorPause; break;
			case pM.pauseMenu: paused = global.pause; break;
			case pM.transition: paused = global.transitionPause; break;
			case pM.shop: paused = global.shop; break;
			default: paused = false; break;
		}
		if (object_index == obj_player){
			print("---");
			print(pauseRestriction);
			print(paused);
		}
		if paused{
			return true;
		}
	}
	return false;
}

