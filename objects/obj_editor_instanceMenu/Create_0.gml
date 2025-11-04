//["instanceId", id]]
if (variable_instance_exists(id,"DOindex")){
	getDisplayObjectInfo(DOindex)
}
SignalSubscribe(id, "openedMenu", function(arg){if arg != id{close()}})
searchForClick(close)

function close(){
	SignalSend("closeMenu: " + string(instanceId))
	instance_destroy()
	instanceId.menu = noone;
}
toDrawArr = [];
function summonOptions(){
	var width = getWidestWidth()
	image_xscale = (width.widest+width.widestArgumentChoices+48)/sprite_width;
	
	var heightNeeded = 32;
	print(instanceArgumentsChoices);
	print(objectArguments);
	for (var i = 0; i < array_length(objectArguments); i++){
		var iAC = ""
		if i < array_length(instanceArgumentsChoices){
			iAC = instanceArgumentsChoices[i]
		}
		summonObject(obj_editor_menu_argumentForm,
			[["coordsOffset",[16+width.widest+coordsOffset[0], i*24+8+coordsOffset[1]]], 
			["type", objectArguments[i].argumentType], ["depth", depth-1],
			["instanceId", instanceId], ["argumentIndex", i], ["name", objectArguments[i].argumentName],
			["argumentChoice",iAC],
			["allArgumentChoices",objectArguments[i].argumentChoices], ["width", width.widestArgumentChoices]]
		);
		heightNeeded += 24;
		
	}
	image_yscale = (heightNeeded)/sprite_height;
}
function getWidestWidth(){
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
	return {widest : widestWidth, widestArgumentChoices: widestWidthArgumentChoices}
}
function getWidestText(textArray, extractNameFunc){
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
	if widestWidth < 64{
		widestWidth = 64
	}
	return widestWidth;
}

summonOptions();