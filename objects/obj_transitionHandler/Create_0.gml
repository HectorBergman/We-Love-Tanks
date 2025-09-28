
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
	toNextStage
}
tMult = 0.3;
waitDelay = 52*tMult;
waitTimer = waitDelay;
tP = transitionPhase.inactive;
tRoomArr = [];
count = 0;
transitionType = -1;
transitionSignal = function(){}
delayNewRoom = ds_list_create();

prevRoom = "";

SignalSubscribe(id, "roomEntered: general", function(){
	var _str = "roomExit" + ": "
	SignalSend(_str + prevRoom);
})

SignalSubscribe(id, "roomEntered: newRoom", function(){
	prevRoom = "newRoom";
})
SignalSubscribe(id, "roomEntered: shop", function(){
	prevRoom = "shop";
})
SignalSubscribe(id, "roomEntered: nextStage", function(){
	prevRoom = "nextStage";
})

SignalSubscribe(id, "transitionStart", function(arg){
	transitionType = arg.transitionType;
	transitionArr = arg.transitionArr
	switch transitionType{
		case (transitionTypes.toRoom):{
			transitionSignal = function(){
				SignalSend("transportRoom", transitionArr)
				ds_list_add(delayNewRoom, "newRoom")
			}
		}break;
		/*case (transitionTypes.toShop):{
			transitionSignal = function(){
				SignalSend("transportShop", transitionArr)
				ds_list_add(delayNewRoom, "shop")
			}
		}break;
		case (transitionTypes.toNextStage):{
			transitionSignal = function(){
				SignalSend("transportNextStage", transitionArr)
				ds_list_add(delayNewRoom, "nextStage")
			}
		}break;*/
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