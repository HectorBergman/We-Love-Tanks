if place_meeting(x,y,obj_player){
	ds_list_add(actionList,setLock);
	setLock(false);
}

if !ds_list_empty(actionList){
	mask_index = spr_lock
	if !place_meeting(x,y,obj_player){
		var len = ds_list_size(actionList)
		for (var i = 0; i < len; i++){
			ds_list_find_value(actionList,i)()
			ds_list_delete(actionList,i);
		}
	}else{
		mask_index = spr_lock_boss
	}
}