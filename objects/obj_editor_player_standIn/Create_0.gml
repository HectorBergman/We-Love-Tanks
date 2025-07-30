held = false;
offset = [0,0]
liftOffCoord = [room_width/2,room_height/2]
player = noone;
searchForClick(function(){liftOffCoord = [x,y]; dragItemInstance(dropped_pStandIn)})
initiateToggleSignal(summonPlayer,unsummonPlayer)

function summonPlayer(){
	dropped_pStandIn();
	visible = false;
	player = summonObject(obj_player, [["x", x], ["y", y]]);
}
function unsummonPlayer(){
	visible = true;
	instance_destroy(player);
}
function dropped_pStandIn(){
	depth = -10;
	held = false;
	if place_meeting(x,y,obj_wall) || !inRange(x, 0, room_width) || !inRange(y, 0, room_height){
		x = liftOffCoord[0];
		y = liftOffCoord[1];
	}else{
		liftOffCoord = [x,y];
	}
}