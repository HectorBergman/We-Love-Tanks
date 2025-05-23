function loop_onHit(){
	for (var i = 0; i < ds_list_size(itemHand.currentItems); i++){
		var item = ds_list_find_value(itemHand.currentItems,i);
		method_call(variable_instance_get(global.items,item).onFire);
	}
}

function