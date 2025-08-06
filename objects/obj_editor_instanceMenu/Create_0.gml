//["instanceId", id]]

searchForClick(close)
function close(){
	SignalSend("closeMenu: " + string(instanceId))
	instance_destroy()
	instanceId.menu = noone;
}
toDrawArr = [];
function summonOptions(){
	print(instanceArgumentsChoices);
	widestWidthNameText = 0;
	widestWidthArgumentText = 0;
	var widestWidth = getWidestText(objectArguments, function(arg, i){ var s = string(arg.argumentName)+ ":"; toDrawArr[i] = scribble(s); return s;});
	var widestWidthArgumentChoices = 0;
	for (var i = 0; i < array_length(objectArguments); i++){
		var width = getWidestText(objectArguments[i].argumentChoices, function(arg, i){return arg});
	
		if width > widestWidthArgumentChoices{
			widestWidthArgumentChoices = width;
		}
	
	}
	image_xscale = (widestWidthArgumentChoices+widestWidth+48)/sprite_width;
	for (var i = 0; i < array_length(objectArguments); i++){
		print(instanceArgumentsChoices[i]);
		
		summonObject(obj_editor_menu_argumentForm,
			[["coordsOffset",[16+widestWidth+coordsOffset[0], i*24+8+coordsOffset[1]]], 
			["type", objectArguments[i].argumentType], ["depth", depth-1],
			["instanceId", instanceId], ["argumentIndex", i], ["name", objectArguments[i].argumentName],
			["argumentChoice",instanceArgumentsChoices[i]],
			["allArgumentChoices",objectArguments[i].argumentChoices], ["width", widestWidthArgumentChoices]]
		);
		
	}
}
function getWidestText(textArray, extractNameFunc){
	print("new")
	print(textArray);
	var widestWidth = 0;
	for (var i = 0; i < array_length(textArray); i++){
		text = "";
		text = "[$eee7e7][scale,1][fnt_coolFont]" + string(extractNameFunc(textArray[i], i));
		toDraw = scribble(text)
		var width = toDraw.get_width();
		if width > widestWidth{
			widestWidth = width;
		}
	}
	return widestWidth;
}

summonOptions();