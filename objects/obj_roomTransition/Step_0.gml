PAUSE
if (place_meeting(x,y,obj_player)){
	if !colliding{
		var diff = [xDiff,yDiff]
		var rNo = roomNo;
		var dNo = doorNo
		SignalSend("transitionRoom", [diff[0],diff[1],rNo,dNo, obj_player.movementVector])
		instance_destroy();
	}
}else{
	colliding = false;
}