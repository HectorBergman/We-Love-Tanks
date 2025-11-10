enum menuStates{
	active,
	inactive,
}
enum gameStates {
	other,
	regular,
	editor,
}
enum editorStates{
	building,
	testing,
}
gameState = gameStates.other
menuState = menuStates.active
editorState = editorStates.building;
SignalSubscribe(id, "changeGameState", function(state){
	gameState = state
})
SignalSubscribe(id, "toggleMenuState", function(state){
	menuState = !menuState
})
SignalSubscribe(id, "changeEditorState", function(state){
	editorState = state
})


function initHandlerStruct(){
	return {
		summonInstructions : {},
		instances : {},
		summoned : false
	}
}


function createSummonStructStruct(goalStruct ,summonStructStruct){
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
alwaysSummon = initHandlerStruct()
createSummonStructStruct(alwaysSummon,
[
	[obj_cam,[]],
	[obj_handler_delay,[]],
	[obj_itemHandler,[]],
	[obj_handler_particle,[]],
	[obj_handler_time,[]],
	[obj_handler_money,[]],
])

//summonAllFromStruct(alwaysSummon)
inGame = {
}
inGame = initHandlerStruct()

createSummonStructStruct(inGame,
[
	[obj_handler_room,[]],
	[obj_player,[["x", 960/2], ["y", 540/2]]],
	[obj_crosshair,[]],
	[obj_handler_minimap,[]],
	[obj_handler_level, []],
	[obj_handler_transition, []],
	[obj_handler_pathfinder, []]
])
//summonAllFromStruct(inGame)
editor = {
}

editor = initHandlerStruct();






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
