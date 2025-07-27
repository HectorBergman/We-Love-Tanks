//["instanceId", id]]
function close(){
	SignalSend("closeMenu: " + string(instanceId))
	instance_destroy()
	instanceId.menu = noone;
}

function summonOptions(){
	print(instanceArgumentsChoices);
	for (var i = 0; i < array_length(objectArguments); i++){
		
		summonObject(obj_editor_menu_argumentForm,[["x",x+8],["y",y+i*24+8], 
		["type", objectArguments[i].argumentType], ["depth", depth-1],
		["instanceId", instanceId], ["argumentIndex", i], 
		["argumentChoice",instanceArgumentsChoices[0]],
		["allArgumentChoices",objectArguments[i].argumentChoices]]);
		
	}
}

summonOptions();