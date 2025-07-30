//SignalSubscribe(id, "editor_pointer: dropped heldObject", function(){held = false});
held = true;
instanceArgumentsChoices = []
setInstanceArgumentsChoices();
menu = noone;
instance = noone;
dragItemInstance();
searchForClick(dragItemInstance)
searchForRightClick(toggleMenu)
initiateToggleSignal(summonInstance,unsummonInstance)

function summonInstance(){
	dropped();
	visible = false;
	var summonArr = []
	var objArgArrLen = array_length(objectArguments)
	for (var i = 0; i < objArgArrLen; i++){
		summonArr[i] = [objectArguments[i].argumentName, instanceArgumentsChoices[i]];
	}//add all the variables we've added to the itemInstance to the instance itself in testing (and in-game)
	summonArr[objArgArrLen]   = ["x", x];
	summonArr[objArgArrLen+1] = ["y", y];
	instance = summonObject(object, summonArr);
}
function unsummonInstance(){
	visible = true;
	instance_destroy(instance);
}

SignalSubscribe(id, "updateInstance: " + string(id), function(arg){updateInstanceArgumentChoices(arg[0],arg[1], arg[2])});

function toggleMenu(){
	if menu == noone{
		openMenu();
	}else{
		closeMenu();
	}
}

function openMenu(){
	menu = summonObject(obj_editor_instanceMenu, [["coordsOffset", [sprite_width,0]], 
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
		case argumentTypes.options:{ //choiceInfo is the number of the argument
			instanceArgumentsChoices[instanceIndex] = objectArguments[instanceIndex].argumentChoices[choiceInfo];
		}break;
		case argumentTypes.checkbox:{ //choiceInfo ignored
			print("letsgo");
			instanceArgumentsChoices[instanceIndex] = !instanceArgumentsChoices[instanceIndex];
		}break;
		case argumentTypes.freetext:{ //choiceInfo is free text
			instanceArgumentsChoices[instanceIndex] = choiceInfo;
		}break;
	}
	
}


function setInstanceArgumentsChoices(){
	//objectArguments is for what parameters and options an object can have,
	//instanceArguments is what those parameters are for that specific instance
	
	//example: 
	
	//objectArguments: {argumentName: "itemPool", argumentType:  argumentTypes.options, 
	//argumentChoices: ["itemPool", "bossPool"]}
	//instanceArguments: "itemPool"
	
	for (var i = 0; i < array_length(objectArguments); i++){
		instanceArgumentsChoices[i] = objectArguments[i].argumentChoices[0]
	}
}