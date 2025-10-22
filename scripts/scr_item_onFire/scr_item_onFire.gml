//functions that trigger upon player fire

function backJack_onFire(fireInfo){
	SignalSend("delay",{timer: 60, func: backJack_onDelay, funcArgs: fireInfo})
}
