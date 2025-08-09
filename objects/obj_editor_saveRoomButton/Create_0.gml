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

SignalSubscribe(id, "updateInstance: " + string(id), function(arg){updateRoom(arg)});
SignalSubscribe(id, "button: clicked", function(arg){if arg[0] == id{print("save!"); saveRoom()}});



function updateRoom(arg){
	var prevShape = instanceArgumentsChoices[1];
	updateInstanceArgumentChoices(arg[0],arg[1], arg[2])
	var newShape = instanceArgumentsChoices[1];
	if prevShape != newShape{
		room_goto(asset_get_index("rm_roomTemplate_" + newShape));
	}
}

function saveRoom(){
	print("saving room!");
	roomInfo = {roomName:"",roomShape:"normal",roomType:"standard",instances:[], savedRandomsNeeded:0}
	roomInfo.roomName  = instanceArgumentsChoices[0];
	roomInfo.roomShape = instanceArgumentsChoices[1];
	roomInfo.roomType  = instanceArgumentsChoices[2];
	totalRandoms = 0;
	SignalSubscribe(id, "saved: addRandom", function(randomAmt){totalRandoms += randomAmt});
	var iIamt = instance_number(obj_editor_itemInstance) 
	if iIamt > 0{
		for (var i = 0; i < iIamt; i++){
			var itemInstance = instance_find(obj_editor_itemInstance, i);
			with itemInstance{
				objectActions.savedAction();
			}
			roomInfo.instances[i] = getActualInstanceSummonArr(itemInstance);
		}
	}
	roomInfo.savedRandomsNeeded = totalRandoms;
	SignalUnsubscribe(id, "saved: addRandom");
	SignalSend("saved room", roomInfo);
}
//saveData(availableRooms, fileName)

