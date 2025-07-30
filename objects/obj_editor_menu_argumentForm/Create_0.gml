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
	case  argumentTypes.options:{
		searchForClick(openDropdown)
	}break;
	case argumentTypes.checkbox:{
		image_index = argumentChoice
		searchForClick(toggleCheckbox)
	}break;
	case argumentTypes.freetext:{
		buffer = argumentChoice
		searchForClick(function(){SignalSend("textbox: selected", [id])})
	}break;
}


function updateArgumentText(){
	text = "";
	switch (type){
		case argumentTypes.options:{
			text = "[$eee7e7][scale,1][fnt_coolFont]" + argumentChoice; 
			toDraw = scribble(text)
		}break;
		case argumentTypes.checkbox:{
		}break;
		case argumentTypes.freetext:{
			var val = buffer;
			text = "[$eee7e7][scale,1][fnt_coolFont]" + val; 
		}break;
	}
	toDraw = scribble(text)
}
function getTextWidestTextPotential(){
	var tempText = ""
	var tempToDraw = noone;
	var widest = 0;
	switch (type){
		case argumentTypes.options:{
			for (var i = 0; i < array_length(allArgumentChoices); i++){
				tempText = "[$eee7e7][scale,1][fnt_coolFont]" + allArgumentChoices[i]; 
				tempToDraw = scribble(tempText)
				var width = tempToDraw.get_width();
				if width > widest{
					widest = width;
				}
			}
		}break;
		case argumentTypes.checkbox:{
		}break;
		case argumentTypes.freetext:{
			var val = buffer;
			tempText = "[$eee7e7][scale,1][fnt_coolFont]" + val; 
			tempToDraw = scribble(tempText)
			widest = tempToDraw.get_width();
		}break;
	}
	return widest;
}
updateArgumentText();



function updateArgumentChoice(argumentType, index, choiceInfo){
	if index == argumentIndex{
		switch (argumentType){
			case argumentTypes.options:{ //choiceInfo is the number of the argument
				if argumentIndex == index{ //if the index sent from the updateInstance signal matches our argumentIndex
					argumentChoice = allArgumentChoices[choiceInfo]
				}
			}break;
			case argumentTypes.checkbox:{ //choiceInfo ignored
				print("letsgo");
				argumentChoice = !argumentChoice;
			}break;
			case argumentTypes.freetext:{ //choiceInfo is free text
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
	SignalSend("updateInstance: " + string(instanceId), [argumentTypes.checkbox,argumentIndex,!isChecked])
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

/*function getWidest(widthToReach){
	
	if toDraw.get_width() > widthToReach{
		widthToReach = toDraw.get_width();
	}
	return widthToReach;
}*/

function activeTextboxLogic(){
	var preBuffer = buffer;
	var _key = keyboard_lastchar;
	print(_key);
	print(string_upper(_key));
	print(keyboard_check_pressed(ord(string_upper(_key))));
	if keyboard_check_pressed(vk_backspace){
		buffer = string_delete(buffer,string_length(buffer),1);
	}else{
		if string_length(buffer) < 256 && keyboard_check_pressed(ord(string_upper(_key))){
			buffer += _key;
		}
	}
	if buffer != preBuffer{
		SignalSend("updateInstance: " + string(instanceId), [argumentTypes.freetext,argumentIndex,buffer]);
	}
}
function start(){
	switch (type){
		case argumentTypes.options:{
		}break;
		case argumentTypes.checkbox:{
		}break;
		case argumentTypes.freetext:{
			SignalSubscribe(id, "textbox: selected", function(arg){textboxSelectedAction(arg)})
		}break;
	}
}
start();
function getSprite(){
	switch (type){
		case argumentTypes.options:{
			sprite_index = spr_roomEditor_menu_dropdown_click;
		}break;
		case argumentTypes.checkbox:{
			sprite_index = spr_roomEditor_checkbox
		}break;
		case argumentTypes.freetext:{
			sprite_index = spr_roomEditor_menu_dropdown_type;
		}break;
	}
}
getSprite();
