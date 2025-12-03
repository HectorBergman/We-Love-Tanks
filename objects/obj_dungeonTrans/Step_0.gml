if active && place_meeting(x,y,obj_player) && listenForInput("interact"){
	active = false;
	SignalSend("newDungeon");
}