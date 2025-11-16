summonedClickables = [];
function menuInstance_close(){
	clickables_unsummon(summonedClickables)
	SignalUnsubscribe(id,"activateMenuInstance")
	instance_destroy()
}


SignalSubscribe(id,"activateMenuInstance",function(instanceName){
	print(name)
	print(instanceName)
	if name != instanceName{
		menuInstance_close()
	}else{
		forceCrash("Attempt to open menu already open: " + name)
	}
})

SignalSubscribe(id,"closeMenuInstance",menuInstance_close)

function clickables_summon(clickables){
	for (var i = 0; i < array_length(clickables); i++){
		var clickable = clickables[i]
		var clickable_index = array_length(summonedClickables)
		summonedClickables[clickable_index] = 
			summonObject(clickable.obj_index, clickable.variables);
		if clickable.doesPopup{
			SignalSend("popup_clickable",
				{
					instance: summonedClickables[clickable_index], 
					popup_info: clickable.popup_info
				}
			)
		}
	}
}
clickables_summon(clickables);

function clickables_unsummon(summonedClickables){
	var arrlen = array_length(summonedClickables)
	for (var i = 0; i < arrlen; i++){
		instance_destroy(summonedClickables[0])
		array_delete(summonedClickables, 0, 1)
	}
}