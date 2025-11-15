summonedClickables = [];

function menuInstance_close(){
	for (var i = 0; i < array_length(summonedClickables); i++){
		instance_destroy(summonedClickables[i]);
	}
}

SignalSubscribe(id,"activateMenuInstance",function(instanceName){
	if name != instanceName{
		menuInstance_close()
	}else{
		forceCrash("Attempt to open menu already open: " + name)
	}
})

function clickables_summon(clickables){
	for (var i = 0; i < array_length(clickables); i++){
		var clickable = clickables[i]
		print(clickable)
		summonedClickables[array_length(summonedClickables)] = 
			summonObject(clickable.obj_index, clickable.variables);
	}
}
clickables_summon(clickables);