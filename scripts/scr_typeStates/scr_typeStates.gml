function createStates(){
	var struct = {};
	for (var i = 0; i < argument_count; i++) {
		variable_struct_set(struct, argument[i], argument[i]);

    }
    return struct;
}

function exeStateFunc(baseName, state){
	script_execute(asset_get_index(baseName + state))
}