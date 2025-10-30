function setDelay(action,time,author,arguments){
	SignalSend("delay", [author, action, time, arguments]);
}