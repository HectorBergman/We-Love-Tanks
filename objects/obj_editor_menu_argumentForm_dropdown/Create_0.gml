print("helloo");
SignalSubscribe(id, "closeMenu: " + string(instanceId), function(){close()});
SignalSubscribe(id, "closeDropdown: " + string(instanceId) + string(argumentIndex), function(){close()})
function updateInstance(){
	SignalSend("updateInstance: " + string(instanceId), [argumentIndex,index]);
	SignalSend("closeDropdown: " + string(instanceId) + string(argumentIndex))
}

function close(){
	print("goodbyyyee");
	instance_destroy()
}