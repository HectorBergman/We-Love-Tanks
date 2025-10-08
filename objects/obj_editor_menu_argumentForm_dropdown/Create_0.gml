if (variable_instance_exists(id,"DOindex")){
	getDisplayObjectInfo(DOindex)
}

SignalSubscribe(id, "closeMenu: " + string(instanceId), function(){close()});
SignalSubscribe(id, "closeDropdown: " + string(instanceId) + string(argumentIndex), function(){close()})
function updateInstance(){
	print("instId: ", instanceId);
	SignalSend("updateInstance: " + string(instanceId), [argumentTypes.options,argumentIndex,index]);
	SignalSend("closeDropdownFromDD: " + string(instanceId) + string(argumentIndex))
}
searchForClick(updateInstance);

function close(){
	instance_destroy()
}