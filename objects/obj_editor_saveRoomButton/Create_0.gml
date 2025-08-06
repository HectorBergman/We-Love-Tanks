depth = -999;
menu = noone;
menuOffset = [0,16]

objectArguments = [
	createArgument("roomName", argumentTypes.freetext),
	createArgument("roomShape", argumentTypes.options, global.roomShapes),
	createArgument("roomType", argumentTypes.options, global.roomTypes)
];

instanceArgumentsChoices = [];
setInstanceArgumentsChoices()

searchForClick(toggleMenu);

SignalSubscribe(id, "updateInstance: " + string(id), function(arg){updateRoom(arg)});


function updateRoom(arg){
	var prevShape = instanceArgumentsChoices[1];
	updateInstanceArgumentChoices(arg[0],arg[1], arg[2])
	var newShape = instanceArgumentsChoices[1];
	if prevShape != newShape{
		room_goto(asset_get_index("rm_roomTemplate_" + newShape));
	}
}
//saveData(availableRooms, fileName)

