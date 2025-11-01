PAUSE
ds_list_add(pathPoints, [x, y]);
if !place_meeting(x,y,obj_player_cannon){
	depth = -99;
}


// Trim path if too long
if (ds_list_size(pathPoints) > maxPathLength) {
    ds_list_delete(pathPoints, 0); // Remove oldest point
}
var index = 0;
for (var i = 0; i < ds_list_size(ignoreList); i++){
	var entity = ds_list_find_value(ignoreList,index);
	if !place_meeting(x,y,entity){
		ds_list_delete(ignoreList,index);
	}else{
		index++
	}
}


if (keyboard_check(vk_space)){
	slowmovin++
}else{
	slowmovin = 0
}
if !(inRange(x,-32,room_width+32) && inRange(y,-32,room_height+32)){
	death();
}

if (slowmovin mod 60 == 0){
	lifeTime++
	exeStateFunc("growth_", growthState)
	//run functions bullet_[state]
	exeStateFunc("bullet_",state);
	
	image_xscale = scale;
	image_yscale = scale;
}




