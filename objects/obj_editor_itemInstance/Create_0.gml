//SignalSubscribe(id, "editor_pointer: dropped heldObject", function(){held = false});

getDisplayObjectInfo(DOindex)
objectActions.appearanceAction(appearanceTypes.appear)
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
if (variable_instance_exists(id, "isFromDisplayObj")){
	if isFromDisplayObj{
		dragItemInstance();
	}
}
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
	var instanceInfo = getActualInstanceSummonArr(id);
	var summonArr = []
	array_copy(summonArr, 0, instanceInfo.instanceArguments,0,array_length(instanceInfo.instanceArguments));
	
	addToSummonStruct(summonArr,instanceInfo.additionalSummonArgs)
	instance = summonObject(instanceInfo.objectIndex, summonArr);
}
function unsummonInstance(){
	visible = true;
	instance_destroy(instance);
}
function dismantle(){
	objectActions.disappearanceAction()
	instance_destroy();
}

SignalSubscribe(id, "updateInstance: " + string(id), function(arg){updateInstanceArgumentChoices(arg[0],arg[1], arg[2])});



