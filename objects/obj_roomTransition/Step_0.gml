PAUSE
if (place_meeting(x,y,obj_player)){
	if !colliding{
		var diff = [xDiff,yDiff]
		var doorNo = roomNo
		with obj_roomHandler{
			enterNewRoom(diff[0],diff[1],doorNo);
		}
	}
}else{
	colliding = false;
}