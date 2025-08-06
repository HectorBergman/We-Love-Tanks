//SignalSubscribe(id, "editor_pointer: dropped heldObject", function(){held = false});
print(objectActions);
objectActions(appearanceTypes.appear)
menu = noone;
instance = noone;
highlight = noone;
menuOffset = [0,0]
function toggleHighlight(){
	if highlight == noone{
		highlight = summonHighlight();
		SignalSubscribe(id, "itemInstance: unhighlight", toggleHighlight);
	}else{
		SignalUnsubscribe(id, "itemInstance: unhighlight");
		with highlight{
			destroy();
		}
		highlight = noone;
	}
}
dragItemInstance();
searchForClick(dragItemInstance)
searchForRightClick(toggleMenu)
initiateToggleSignal(summonInstance,unsummonInstance)


function summonHighlight(){
	return summonObject(obj_editor_itemInstance_highlight, [["parent", id], ["canResize", canResize]])
}
function summonInstance(){
	closeMenu()
	dropped();
	visible = false;
	var summonArr = []
	var objArgArrLen = array_length(objectArguments)
	for (var i = 0; i < objArgArrLen; i++){
		summonArr[i] = [objectArguments[i].argumentName, instanceArgumentsChoices[i]];
	}//add all the variables we've added to the itemInstance to the instance itself in testing (and in-game)
	var extraArguments = [["x", x],["y", y],["image_xscale", image_xscale],["image_yscale", image_yscale]];
	addToSummonStruct(summonArr,extraArguments)
	
	
	instance = summonObject(object, summonArr);
}
function unsummonInstance(){
	visible = true;
	instance_destroy(instance);
}
function dismantle(){
	objectArguments.appearanceAction(appearanceTypes.disappear)
	instance_destroy();
}

SignalSubscribe(id, "updateInstance: " + string(id), function(arg){updateInstanceArgumentChoices(arg[0],arg[1], arg[2])});



