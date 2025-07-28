//SignalSubscribe(id, "editor_pointer: dropped heldObject", function(){held = false});
held = true;
instanceArgumentsChoices = []
setInstanceArgumentsChoices();
menu = noone;

SignalSubscribe(id, "updateInstance: " + string(id), function(arg){updateInstanceArgumentChoices(arg[0],arg[1], arg[2])});

function toggleMenu(){
	if menu == noone{
		openMenu();
	}else{
		closeMenu();
	}
}

function openMenu(){
	menu = summonObject(obj_editor_instanceMenu, [["x", x],["y",y], 
	["depth", depth-1], ["instanceId", id], 
	["instanceArgumentsChoices", instanceArgumentsChoices],
	["objectArguments", objectArguments]]);
	
}
function closeMenu(){
	with menu{
		close()
	}
}
function updateInstanceArgumentChoices(argumentType,instanceIndex,choiceInfo){
	print("haii");
	switch (argumentType){
		case "options":{ //choiceInfo is the number of the argument
			instanceArgumentsChoices[instanceIndex] = objectArguments[instanceIndex].argumentChoices[choiceInfo];
		}break;
		case "checkbox":{ //choiceInfo ignored
			print("letsgo");
			instanceArgumentsChoices[instanceIndex] = !instanceArgumentsChoices[instanceIndex];
		}break;
		case "freeText":{ //choiceInfo is free text
			argumentChoice = choiceInfo;
		}break;
	}
	
}
function dropped(){
	depth = -10;
	held = false;
	SignalSend("itemInstance: dropped", [id]);
}

function setInstanceArgumentsChoices(){
	//objectArguments is for what parameters and options an object can have,
	//instanceArguments is what those parameters are for that specific instance
	
	//example: 
	
	//objectArguments: {argumentName: "itemPool", argumentType: "options", 
	//argumentChoices: ["itemPool", "bossPool"]}
	//instanceArguments: "itemPool"
	
	for (var i = 0; i < array_length(objectArguments); i++){
		instanceArgumentsChoices[i] = objectArguments[i].argumentChoices[0]
	}
}