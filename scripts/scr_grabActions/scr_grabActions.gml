function dragItemInstance(func = dropped){
	held = true;
	depth = -260;
	searchForRelease(func)
}
function dropped(){
	depth = -10;
	held = false;
	SignalSend("itemInstance: dropped", [id]);
	cleanUpSearchForRelease()
}
	
function spawnItemInstance(){
	summonObject(obj_editor_itemInstance, 
	[["sprite_index", sprite_index], ["offset", [0,0]], ["depth", -260], ["objectArguments", objectArguments]]);
}