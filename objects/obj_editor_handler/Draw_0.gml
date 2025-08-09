switch (menuMode){
	case editorMenuModes.selectingRoom:{
		for (var i = 0; i < array_length(toDrawArray); i++;){
			toDrawArray[i].draw(64,32+i*64);
		}
	}break;
	case editorMenuModes.editingRoom:{
	}break;
}