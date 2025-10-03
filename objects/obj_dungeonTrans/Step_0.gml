if active && place_meeting(x,y,obj_player) && obj_inputHandler.interact{
	print("yaywein");
	active = true;
	SignalSend("newDungeon");
}