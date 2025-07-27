SignalSubscribe(id, "closeMenu: " + string(instanceId), function(){close()});
SignalSubscribe(id, "updateInstance: " + string(instanceId), function(arg){updateArgumentChoice(arg[0],arg[1])});
SignalSubscribe(id, "closeDropdown: " + string(instanceId) + string(argumentIndex), function(){isOpen = false;})
isOpen = false;
function updateArgumentChoice(index, choiceNumber){
	if argumentIndex == index{ //if the index sent from the updateInstance signal matches our argumentIndex
		argumentChoice = allArgumentChoices[choiceNumber]
	}
}

function close(){
	instance_destroy();
}
function closeDropdown(){
	SignalSend("closeDropdown: " + string(instanceId) + string(argumentIndex))
}

function updateValue(){
	SignalSend("updateInstance: " + string(instanceId), [])
}
function openDropdown(){
	if !isOpen{
		for (var i = 0; i < array_length(allArgumentChoices); i++){
			summonObject(obj_editor_menu_argumentForm_dropdown, 
				[["isLast", i == array_length(allArgumentChoices)-1], 
				["value", allArgumentChoices[i]], ["x", x], 
				["y", y+sprite_height+(sprite_height-2)*i], 
				["argumentIndex", argumentIndex], ["index", i],
				["image_xscale", image_xscale], ["instanceId", instanceId],
				["depth", depth]])
		}
		isOpen = true;
	}
}

function getSprite(){
	switch (type){
		case "options":{
			sprite_index = spr_roomEditor_menu_dropdown_click;
		}break;
		case "checkbox":{
			sprite_index = spr_roomEditor_checkbox
		}break;
		case "freeText":{
			sprite_index = spr_roomEditor_menu_dropdown_type;
		}break;
	}
}
getSprite();
