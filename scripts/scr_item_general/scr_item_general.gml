function loop_onFire(){
	for (var i = 0; i < ds_list_size(itemHand.currentItems); i++){
		var item = ds_list_find_value(itemHand.currentItems,i);
		var func = variable_instance_get(global.items,item).onFire;
		if !is_undefined(func){
			method_call(func);
		}
	}
}

function loop_onHit(){
	for (var i = 0; i < ds_list_size(itemHand.currentItems); i++){
		var item = ds_list_find_value(itemHand.currentItems,i);
		var func = variable_instance_get(global.items,item).onHit;
		if !is_undefined(func){
			method_call(func);
		}
	}
}