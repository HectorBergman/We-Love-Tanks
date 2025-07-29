//["instanceId", id]]
function close(){
	SignalSend("closeMenu: " + string(instanceId))
	instance_destroy()
	instanceId.menu = noone;
}

function summonOptions(){
	print(instanceArgumentsChoices);
	for (var i = 0; i < array_length(objectArguments); i++){
		print(instanceArgumentsChoices[i]);
		summonObject(obj_editor_menu_argumentForm,[["coordsOffset",[8+coordsOffset[0], i*24+8+coordsOffset[1]]], 
		["type", objectArguments[i].argumentType], ["depth", depth-1],
		["instanceId", instanceId], ["argumentIndex", i], 
		["argumentChoice",instanceArgumentsChoices[i]],
		["allArgumentChoices",objectArguments[i].argumentChoices],]);
		
	}
}

summonOptions();