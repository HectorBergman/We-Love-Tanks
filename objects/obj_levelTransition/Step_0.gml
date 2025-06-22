PAUSE
if (place_meeting(x,y,obj_player)){
	if !colliding{
		var diff = [xDiff,yDiff]
		var rNo = roomNo;
		var dNo = doorNo
		with obj_levelHandler{
			enterLevel();
		}
	}
}else{
	colliding = false;
}