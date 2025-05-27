image_alpha = 0.5;
if (!instance_exists(parent)){
	instance_destroy();
}
if (place_meeting(x,y,obj_solid)){
	parent.wallSeen++
}
if(place_meeting(x,y,playerTank)){
	parent.playerSeen = true;
}
instance_destroy();