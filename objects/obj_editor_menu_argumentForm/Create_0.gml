SignalSubscribe(id, "closeMenu: " + string(instanceId), function(){close()});
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

function close(){
	instance_destroy();
}
function closeDropdown(){
	SignalSend("closeDropdown: " + string(instanceId) + string(argumentIndex))
}

function updateValue(){
	SignalSend("newValue: " + string(instanceId), [])
}
function openDropdown(){
	print("weee");
	print(array_length(allArgumentChoices));
	for (var i = 0; i < array_length(allArgumentChoices); i++){
		summonObject(obj_editor_menu_argumentForm_dropdown, 
			[["isLast", i == array_length(allArgumentChoices)-1], 
			["value", allArgumentChoices[i]], ["x", x], 
			["y", y+sprite_height+(sprite_height-2)*i], 
			["argumentIndex", argumentIndex], ["index", i],
			["image_xscale", image_xscale], ["instanceId", instanceId],
			["depth", depth]])
	}
}