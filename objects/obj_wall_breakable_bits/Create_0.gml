pauseMode = [pM.pauseMenu];
collideable = true;

SignalSubscribe(id, "bomb_found: " + string(id), function(){
	instance_destroy()
	SignalUnsubscribe(id, "bomb_found: " + string(id))
})