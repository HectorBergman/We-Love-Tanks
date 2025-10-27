function createStates(){
	var struct = {};
	for (var i = 0; i < argument_count; i++) {
		variable_struct_set(struct, argument[i], argument[i]);

    }
    return struct;
}

function exeStateFunc(baseName, state){
	var func = asset_get_index(baseName + state)
	if func != -1{
		script_execute(asset_get_index(baseName + state))
	}else{
		print(baseName + state);
		forceCrash(baseName + state + " is not a function!");
	}
}