
SignalSubscribe(id, "bomb_found: " + string(id), function(){
	print("found");
	mask_index = spr_breakable_help
	var tempX = 0
	var tempY = 0
	for (var j = 0; j < 8; j++){
		for (var i = 0; i < 8; i++){
			if !place_meeting(x+4*i,y+4*j,obj_explosion){
				summonObject(obj_wall_breakable_bits,[["x", x+4*i],["y", y+4*j]])
			}
		}
	}
	
	instance_destroy()
	SignalUnsubscribe(id, "bomb_found: " + string(id))

});