if (variable_instance_exists(id,"DOindex")){
	getDisplayObjectInfo(DOindex)
}

SignalSubscribe(id, "closeMenu: " + string(instanceId), function(){close()});
SignalSubscribe(id, "updateInstance: " + string(instanceId), function(arg){updateArgumentChoice(arg[0],arg[1],arg[2])});
SignalSubscribe(id, "closeDropdownFromDD: " + string(instanceId) + string(argumentIndex), function(){toggleDropdown();})
SignalSubscribe(id, "openDropdown: " + string(instanceId), function(arg){if arg[0] != id && isOpen{ toggleDropdown();}})

//dropdown
isOpen = false; 
//

//checkbox
isChecked = argumentChoice;
//

//freetext
isActive = false; 
buffer = "";
maxLetters =getMaxVisibleLetters()
backSpaceStartTime = 10;
backSpaceTimer = 0;
backSpaceHoldTime = 3;
//

function getMaxVisibleLetters(){
	var val = "a"
	tempText = "[$eee7e7][scale,1][fnt_coolFont]" + val; 
	tempToDraw = scribble(tempText)
	var width1 = tempToDraw.get_width();
	return floor(width/width1);
}

switch (type){
	case  argumentTypes.options:{
		searchForClick(toggleDropdown)
	}break;
	case argumentTypes.checkbox:{
		image_index = argumentChoice
		searchForClick(toggleCheckbox)
	}break;
	case argumentTypes.freetext:{
		buffer = argumentChoice
		searchForClick(function(){SignalSend("textbox: selected", [id])})
		SignalSubscribe(id,"editor_clicked", function(arg){if arg != id{ deactivateTextbox()}});
	}break;
	case argumentTypes.button:{
		searchForClick(function(){SignalSend("button: clicked", [instanceId])})
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
			var lengthDiff =  maxLetters- string_length(val) 
			if lengthDiff < 0{
				val = string_delete(val, 0, -lengthDiff);
			}
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


function toggleDropdown(){
	if !isOpen{
		SignalSend("openDropdown: " + string(instanceId), [id]);
		image_index = 1;
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
	}else{
		image_index = 0;
		closeDropdown();
		isOpen = false;
	}
}
function textboxSelectedAction(arg){
	if arg[0] == id{
		activateTextbox();
	}else{
		deactivateTextbox();
	}
}
function activateTextbox(){
	image_index = 1;
	isActive = true;
}
function deactivateTextbox(){
	image_index = 0;
	isActive = false;
}


function activeTextboxLogic(){
	var preBuffer = buffer;
	var _key = keyboard_lastchar;
	if keyboard_check(vk_backspace){
		if keyboard_check_pressed(vk_backspace){
			buffer = string_delete(buffer,string_length(buffer),1);
		}else{
			
		}
	}else{
		if string_length(buffer) < 256{
			buffer += _key;
		}
	}
	if buffer != preBuffer{
		SignalSend("updateInstance: " + string(instanceId), [argumentTypes.freetext,argumentIndex,buffer]);
	}
	keyboard_lastchar = "";
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
			image_xscale = (width+16)/sprite_width;
		}break;
		case argumentTypes.checkbox:{
			sprite_index = spr_roomEditor_checkbox
		}break;
		case argumentTypes.freetext:{
			sprite_index = spr_roomEditor_menu_dropdown_type;
			image_xscale = (width+16)/sprite_width;
		}break;
		case argumentTypes.button:{
			sprite_index = spr_roomEditor_menu_dropdown_confirm
			image_xscale = (width+16)/sprite_width;
		}break;
	}
}
getSprite();
