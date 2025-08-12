function dragItemInstance(func = dropped){
	SignalSend("itemInstance: unhighlight");
	toggleHighlight();
	heldOffset = [x-mouse_x, y-mouse_y];
	held = true;
	depth = -260;
	searchForRelease(func)
}
function dropped(){
	depth = -140;
	held = false;
	SignalSend("itemInstance: dropped", [id]);
	cleanUpSearchForRelease()
}
	
function spawnItemInstance(){
	var summonStruct = 
		[["sprite_index", sprite_index], 
		["heldOffset", [0,0]], 
		["depth", -260],
		["canResize", canResize],
		["isFromDisplayObj", true]]
	addObjectVariablesToSummonStruct(summonStruct, false);
	var iInstance = summonObject(obj_editor_itemInstance, summonStruct
	);
	with iInstance{
		instanceArgumentsChoices = []
		setInstanceArgumentsChoices();
	}
}

function setInstanceArgumentsChoices(){
	//objectArguments is for what parameters and options an object can have,
	//instanceArguments is what those parameters are for that specific instance
	
	//example: 
	
	//objectArguments: {argumentName: "itemPool", argumentType:  argumentTypes.options, 
	//argumentChoices: ["itemPool", "bossPool"]}
	//instanceArguments: "itemPool"
	print(objectArguments);
	for (var i = 0; i < array_length(objectArguments); i++){
		
		instanceArgumentsChoices[i] = objectArguments[i].argumentChoices[0]
	}
}