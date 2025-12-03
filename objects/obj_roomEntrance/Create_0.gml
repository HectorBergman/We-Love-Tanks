SignalSubscribe(id, "roomEntranceNo", function(arg){
	if arg[0] == entranceDoor && arg[1] == roomNo{
		obj_player.x = x + arg[2][0]; //arg[2] == offset
		obj_player.y = y + arg[2][1];
		
		print("playerMoved");
		SignalSend("playerMoved")	
	}
})
