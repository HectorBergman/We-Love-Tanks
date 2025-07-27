//SignalSubscribe(id, "editor_pointer: dropped heldObject", function(){held = false});
held = true;
instanceArgumentsChoices = []
setInstanceArgumentsChoices();
print("penis!");
print(instanceArgumentsChoices);
menu = noone;

SignalSubscribe(id, "updateInstance: " + string(id), function(arg){updateInstanceArgumentChoices(arg[0],arg[1])});

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
function updateInstanceArgumentChoices(instanceIndex,choiceIndex){
	instanceArgumentsChoices[instanceIndex] = objectArguments[instanceIndex].argumentChoices[choiceIndex];
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