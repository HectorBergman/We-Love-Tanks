depth = -300;
print("button: ", id);
menu = noone;
menuOffset = [0,16]
totalRandoms = 0;
objectArguments = [
	createArgument("roomName", argumentTypes.freetext),
	createArgument("roomShape", argumentTypes.options, global.roomShapes),
	createArgument("roomType", argumentTypes.options, global.roomTypes),
	createArgument("subType", argumentTypes.options, global.roomSubtypes),
	createArgument("save", argumentTypes.button)
];

instanceArgumentsChoices = [];
setInstanceArgumentsChoices()

updateSubtypes();

function updateSubtypes(){
	print("updatingSubtypes");
	global.roomSubtypes = variable_struct_get(global.roomSubtypes_dict, instanceArgumentsChoices[2])
	objectArguments[3] = createArgument("subType", argumentTypes.options, global.roomSubtypes)
	
}

searchForClick(toggleMenu);
SignalSubscribe(id, "editor_handler: enterRoom", 
	function(arg){
		instanceArgumentsChoices = [arg.roomName, arg.roomShape, arg.roomType, objectArguments[3].argumentChoices[0]]; 
		SignalUnsubscribe(id, "editor_handler: enterRoom")
	}
)
SignalSubscribe(id, "updateInstance: " + string(id), function(arg){updateRoom(arg);});
SignalSubscribe(id, "button: clicked", function(arg){if arg[0] == id{print("save!"); button_saveRoom()}});


function updateRoom(arg){
	print("updateRoom");
	var prevShape = instanceArgumentsChoices[1];
	updateInstanceArgumentChoices(arg[0],arg[1], arg[2])
	var newShape = instanceArgumentsChoices[1];
	updateSubtypes()
	if prevShape != newShape{
		room_goto(asset_get_index("rm_roomTemplate_" + newShape));
	}
	print(instanceArgumentsChoices);
}

function button_saveRoom(){
	print("saving room!");
	var roomKeys = [
	    "roomName",
	    "roomShape",
	    "roomType",
	    "roomSubtype",
	];

	roomInfo = {instances:[], savedRandomsNeeded:0}
	for (var i = 0; i < array_length(roomKeys); i++) {
		print(roomKeys[i],": ", instanceArgumentsChoices[i]);
		variable_struct_set(roomInfo, roomKeys[i], instanceArgumentsChoices[i]);
	}
	print(roomInfo);

	totalRandoms = 0;
	SignalSubscribe(id, "saved: addRandom", function(randomAmt){totalRandoms += randomAmt});
	var iIamt = instance_number(obj_editor_itemInstance) 
	if iIamt > 0{
		for (var i = 0; i < iIamt; i++){
			var iInst = instance_find(obj_editor_itemInstance, i);
			with iInst{
				objectActions.savedAction();
			}
			roomInfo.instances[i] = {
				displayObjIndex : iInst.DOindex,
				instanceArgumentsChoices: iInst.instanceArgumentsChoices,
				summonArr : [
					["image_xscale", iInst.image_xscale],
					["image_yscale", iInst.image_yscale],
					["x", iInst.x],
					["y", iInst.y],
					["sprite_index", iInst.sprite_index], 
					["heldOffset", [0,0]], 
					["depth", -260],
					["canResize", iInst.canResize],
					["held", false]
				]
			}
		}
	}
	roomInfo.savedRandomsNeeded = totalRandoms;
	SignalUnsubscribe(id, "saved: addRandom");
	SignalSend("saved room", roomInfo);
}
//saveData(availableRooms, fileName)

