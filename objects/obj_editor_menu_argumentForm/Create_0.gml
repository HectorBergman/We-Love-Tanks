SignalSubscribe(id, "closeMenu: " + string(instanceId), function(){close()});
SignalSubscribe(id, "updateInstance: " + string(instanceId), function(arg){updateArgumentChoice(arg[0],arg[1],arg[2])});
SignalSubscribe(id, "closeDropdown: " + string(instanceId) + string(argumentIndex), function(){isOpen = false;})
print("newone")
print(argumentChoice);
print("done");
isOpen = false; //dropdown
isChecked = argumentChoice; //checkbox
isActive = false; //freetext
buffer = "";
switch (type){
	case "options":{
		searchForClick(openDropdown)
	}break;
	case "checkbox":{
		image_index = argumentChoice
		searchForClick(toggleCheckbox)
	}break;
	case "freeText":{
		buffer = argumentChoice
		searchForClick(function(){SignalSend("textbox: selected", [id])})
	}break;
}


function updateArgumentChoice(argumentType, index, choiceInfo){
	if index == argumentIndex{
		switch (argumentType){
			case "options":{ //choiceInfo is the number of the argument
				if argumentIndex == index{ //if the index sent from the updateInstance signal matches our argumentIndex
					argumentChoice = allArgumentChoices[choiceInfo]
				}
			}break;
			case "checkbox":{ //choiceInfo ignored
				print("letsgo");
				argumentChoice = !argumentChoice;
			}break;
			case "freeText":{ //choiceInfo is free text
				argumentChoice = choiceInfo;
			}break;
		}
	}
	
}

function close(){
	instance_destroy();
}
function closeDropdown(){
	SignalSend("closeDropdown: " + string(instanceId) + string(argumentIndex))
}

function toggleCheckbox(){
	image_index = (image_index+1) mod 2
	SignalSend("updateInstance: " + string(instanceId), ["checkbox",argumentIndex,!isChecked])
	isChecked = true;
}


function openDropdown(){
	if !isOpen{
		for (var i = 0; i < array_length(allArgumentChoices); i++){
			summonObject(obj_editor_menu_argumentForm_dropdown, 
				[["isLast", i == array_length(allArgumentChoices)-1], 
				["value", allArgumentChoices[i]], 
				["coordsOffset", [0+coordsOffset[0], sprite_height+(sprite_height-2)*i+coordsOffset[1]]],
				["argumentIndex", argumentIndex], ["index", i],
				["image_xscale", image_xscale], ["instanceId", instanceId],
				["depth", depth]])
		}
		isOpen = true;
	}
}
function textboxSelectedAction(arg){
	print("haii");
	if arg[0] == id{
		activateTextbox();
	}else{
		deactivateTextbox();
	}
}
function activateTextbox(){
	isActive = true;
}
function deactivateTextbox(){
	isActive = false;
}

function activeTextboxLogic(){
	var preBuffer = buffer;
	var _key = keyboard_lastchar;
	print(_key);
	print(string_upper(_key));
	print(keyboard_check_pressed(ord(string_upper(_key))));
	if keyboard_check_pressed(vk_backspace){
		buffer = string_delete(buffer,string_length(buffer),1);
	}else{
		if keyboard_check_pressed(ord(string_upper(_key))){
			buffer += _key;
		}
	}
	if buffer != preBuffer{
		SignalSend("updateInstance: " + string(instanceId), ["freeText",argumentIndex,buffer]);
	}
}
function start(){
	switch (type){
		case "options":{
		}break;
		case "checkbox":{
		}break;
		case "freeText":{
			SignalSubscribe(id, "textbox: selected", function(arg){textboxSelectedAction(arg)})
		}break;
	}
}
start();
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
