
enum transitionPhase {
	inactive,
	start,
	wait,
	wait2,
	endTransition
}
tMult = 0.3;
waitDelay = 52*tMult;
waitTimer = waitDelay;
tP = transitionPhase.inactive;
tRoomArr = [];
count = 0;
SignalSubscribe(id, "transitionRoom", function(arg){
	tRoomArr = arg
	global.transitionPause = true;
	tP = transitionPhase.start;
})
SignalSubscribe(id, "transitionLevel", function(){})