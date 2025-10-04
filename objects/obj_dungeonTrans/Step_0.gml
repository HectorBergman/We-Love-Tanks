if active && place_meeting(x,y,obj_player) && obj_inputHandler.interact{
	active = true;
	SignalSend("newDungeon");
}