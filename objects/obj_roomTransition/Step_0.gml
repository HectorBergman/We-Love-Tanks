PAUSE
if (place_meeting(x,y,obj_player)){
	if !colliding{
		var diff = [xDiff,yDiff]
		var rNo = roomNo;
		var dNo = doorNo
		with obj_roomHandler{
			enterNewRoom(diff[0],diff[1],rNo,dNo);
		}
	}
}else{
	colliding = false;
}