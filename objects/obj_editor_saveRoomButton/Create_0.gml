depth = -300;
menu = noone;
menuOffset = [0,16]
totalRandoms = 0;
objectArguments = [
	createArgument("roomName", argumentTypes.freetext),
	createArgument("roomShape", argumentTypes.options, global.roomShapes),
	createArgument("roomType", argumentTypes.options, global.roomTypes),
	createArgument("save:", argumentTypes.button)
];

instanceArgumentsChoices = [];
setInstanceArgumentsChoices()

searchForClick(toggleMenu);
SignalSubscribe(id, "editor_handler: enterRoom", 
	function(arg){
		instanceArgumentsChoices = [arg.roomName, arg.roomShape, arg.roomType, objectArguments[3].argumentChoices[0]]; 
		SignalUnsubscribe(id, "editor_handler: enterRoom")
	}
)
SignalSubscribe(id, "updateInstance: " + string(id), function(arg){updateRoom(arg)});
SignalSubscribe(id, "button: clicked", function(arg){if arg[0] == id{print("save!"); button_saveRoom()}});


function updateRoom(arg){
	var prevShape = instanceArgumentsChoices[1];
	updateInstanceArgumentChoices(arg[0],arg[1], arg[2])
	var newShape = instanceArgumentsChoices[1];
	if prevShape != newShape{
		room_goto(asset_get_index("rm_roomTemplate_" + newShape));
	}
}

function button_saveRoom(){
	print("saving room!");
	roomInfo = {roomName:"",roomShape:"normal",roomType:"standard",instances:[], savedRandomsNeeded:0}
	roomInfo.roomName  = instanceArgumentsChoices[0];
	roomInfo.roomShape = instanceArgumentsChoices[1];
	roomInfo.roomType  = instanceArgumentsChoices[2];
	totalRandoms = 0;
	SignalSubscribe(id, "saved: addRandom", function(randomAmt){totalRandoms += randomAmt});
	var iIamt = instance_number(obj_editor_itemInstance) 
	if iIamt > 0{
		print("imafraud");
		for (var i = 0; i < iIamt; i++){
			var iInst = instance_find(obj_editor_itemInstance, i);
			with iInst{
				objectActions.savedAction();
			}
			print("save!");
			print(iInst.objectActions);
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

