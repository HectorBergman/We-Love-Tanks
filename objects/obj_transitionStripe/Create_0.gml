enum tD_phase {
	start,
	wait,
	completed
}
tween = noone;
phase = tD_phase.start
loops = 0;
if !isBlue{
	ease = EaseLinear;
}else{
	ease = EaseLinear;
}
sentSignal = false;
SignalSubscribe(id,"transportRoom", function(){
		phase = tD_phase.start
	})
SignalSubscribe(id,"transitionEnd", function(arg){ if arg[0] == count{instance_destroy()}})