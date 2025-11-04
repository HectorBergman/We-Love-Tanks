if active && place_meeting(x,y,obj_player) && obj_handler_input.interact{
	active = false;
	SignalSend("newDungeon");
}