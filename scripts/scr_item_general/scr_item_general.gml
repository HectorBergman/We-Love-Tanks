function loop_onFire(){
	for (var i = 0; i < ds_list_size(itemHand.currentItems); i++){
		var item = ds_list_find_value(itemHand.currentItems, i);
        var itemData = variable_instance_get(global.items, item);
        
        // Check if itemData exists and has onHit property
        if (variable_instance_exists(global.items, item) && 
            variable_instance_exists(itemData, "onFire")) {
            var func = itemData.onFire;
            method_call(func);
        }
	}
}

function loop_onHit(){
	for (var i = 0; i < ds_list_size(itemHand.currentItems); i++){
		var item = ds_list_find_value(itemHand.currentItems, i);
        var itemData = variable_instance_get(global.items, item);
        
        // Check if itemData exists and has onHit property
        if (variable_instance_exists(global.items, item) && 
            variable_instance_exists(itemData, "onHit")) {
            var func = itemData.onHit;
            method_call(func);
        }
	}
}