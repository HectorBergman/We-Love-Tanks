held = false;
offset = [0,0]
liftOffCoord = [0,0]
searchForClick(function(){liftOffCoord = [x,y]; dragItemInstance(dropped_pStandIn)})

function dropped_pStandIn(){
	depth = -10;
	held = false;
	if place_meeting(x,y,obj_wall) || !inRange(x, 0, room_width) || !inRange(y, 0, room_height){
		x = liftOffCoord[0];
		y = liftOffCoord[1];
	}
}