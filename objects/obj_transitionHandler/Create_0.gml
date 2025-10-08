
enum transitionPhase {
	inactive,
	start,
	wait,
	wait2,
	endTransition
}
enum transitionTypes {
	toRoom,
	toShop,
	newDungeon
}
tMultBase = 0.3
tMult = 1*tMultBase;

waitDelay = 52*tMult;
waitTimer = waitDelay;
tP = transitionPhase.inactive;
tRoomArr = [];
transitionId = 0;
transitionType = -1;
transitionSignal = function(){}
delayNewRoom = ds_list_create();

prevRoom = "";

SignalSubscribe(id, "roomEntered: general", function(){
	//unused rn
	var _str = "roomExit" + ": "
	SignalSend(_str + prevRoom);
})


SignalSubscribe(id, "transitionStart", function(arg){
	tMult = tMultBase*arg.transitionLengthMult
	transitionType = arg.transitionType;
	transitionStruct = arg.transitionStruct
	switch transitionType{
		case (transitionTypes.toRoom):{
			transitionSignal = function(){
				SignalSend("transportRoom", transitionStruct)
				ds_list_add(delayNewRoom, "newRoom")
			}
		}break;
		case (transitionTypes.newDungeon):{
			transitionSignal = function(){
				SignalSend("transportRoom", transitionStruct)
				ds_list_add(delayNewRoom, "newRoom")
			}
		}break;
	}
	global.transitionPause = true;
	tP = transitionPhase.start;
})
SignalSubscribe(id, "transitionLevel", function(){})


function signalList(list,signalText){
	var _str = signalText + ": "
	for (var i = 0; i < ds_list_size(list); i++){
		SignalSend(_str + ds_list_find_value(list,i));
	}

	ds_list_clear(list);
}