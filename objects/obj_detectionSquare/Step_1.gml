if (place_meeting(x,y,obj_wall)){
	parent.wallSeen++
}
if(place_meeting(x,y,playerTank)){
	parent.playerSeen = true;
}
instance_destroy();