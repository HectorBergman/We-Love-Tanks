pauseMode = [pM.pauseMenu];
collideable = true;
SignalSubscribe(id, "bomb_found: " + string(id), sunder);

function sunder(){
	mask_index = spr_breakable_help
	var tempX = 0
	var tempY = 0
	for (var j = 0; j < sprite_height/4; j++){
		for (var i = 0; i < sprite_width/4; i++){
			if !place_meeting(x+4*i,y+4*j,[obj_explosion, obj_player]){
				summonObject(obj_wall_breakable_bits,
				[["x", x+4*i],
				 ["y", y+4*j], 
				 ["roomNo", roomNo], 
				 ["doorNo", doorNo]])
			}
		}
	}
	
	instance_destroy()
	SignalUnsubscribe(id, "bomb_found: " + string(id))
}


