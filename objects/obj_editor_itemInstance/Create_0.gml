//SignalSubscribe(id, "editor_pointer: dropped heldObject", function(){held = false});
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
	var summonArr = getActualInstanceSummonArr(id);
	
	
	instance = summonObject(summonArr[0], summonArr[1]);
}
function unsummonInstance(){
	visible = true;
	instance_destroy(instance);
}
function dismantle(){
	print(objectActions);
	objectActions.disappearanceAction()
	instance_destroy();
}

SignalSubscribe(id, "updateInstance: " + string(id), function(arg){updateInstanceArgumentChoices(arg[0],arg[1], arg[2])});



