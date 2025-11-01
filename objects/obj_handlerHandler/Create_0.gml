
function initHandlerStruct(){
	return {
		summonInstructions : {},
		instances : {},
		summoned : false
	}
}


function createSummonStructStruct(goalStruct ,summonStructStruct){
	print(goalStruct)
	for (var i = 0; i < array_length(summonStructStruct); i++){
		var name = object_get_name(summonStructStruct[i][0])
		var noobj_name = string_delete(name, 1, 4);
		variable_struct_set(goalStruct.summonInstructions, noobj_name, summonStructStruct[i]);
	}
}

function summonAllFromStruct(struct){
	if !struct.summoned{
		var keys = variable_struct_get_names(struct.summonInstructions);

		for (var i = 0; i < array_length(keys); i++) {
			var key = keys[i];
			var value = variable_struct_get(struct.summonInstructions, key);
			variable_struct_set(struct.instances, keys[i], summonObject(value[0],value[1]));
		}
	}
	struct.summoned = true;
}
alwaysSummon = {
}
print("test")
alwaysSummon = initHandlerStruct()
print("test");
createSummonStructStruct(alwaysSummon,
[
	[obj_cam,[]],
	[obj_delayHandler,[]],
	[obj_itemHandler,[]],
	[obj_particleHandler,[]]
])
print("test");
//summonAllFromStruct(alwaysSummon)
inGame = {
}
inGame = initHandlerStruct()

createSummonStructStruct(inGame,
[
	[obj_roomHandler_true,[]],
	[obj_player,[["x", 960/2], ["y", 540/2]]],
	[obj_crosshair,[]],
	[obj_minimapHandler_true,[]],
	[obj_levelHandler, []],
	[obj_transitionHandler, []],
	[obj_pathFinderHandler, []]
])
//summonAllFromStruct(inGame)
editor = {
}






function dismantle_instanceStruct(struct){
	if struct.summoned{
		var keys = variable_struct_get_names(struct.instances);
	
		// Iterate through them
		for (var i = 0; i < array_length(keys); i++) {
			var key = keys[i];
			var value = variable_struct_get(struct.instances, key);
			instance_destroy(value);
			variable_struct_remove(struct.instances, key)
		}
	}
	struct.summoned = false;
}
