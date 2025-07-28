switch (type){
	case "options":{
		if place_meeting(x,y,obj_editor_pointer) && obj_inputHandler.click{
			openDropdown();
		}
	}break;
	case "checkbox":{
		if place_meeting(x,y,obj_editor_pointer) && obj_inputHandler.click{
			toggleCheckbox();
		}
	}break;
	case "freeText":{
		if place_meeting(x,y,obj_editor_pointer) && obj_inputHandler.click{
			SignalSend("textbox: selected", [id])
		}
		if isActive{
			activeTextboxLogic()
		}
	}break;
}
