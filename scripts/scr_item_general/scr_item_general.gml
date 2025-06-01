//yea im repeating myself but this is probably easier than making a function where u just put in
//onBulletTravel as a parameter so lol

function loop_onBulletTravel(){
	for (var i = 0; i < ds_list_size(obj_itemHandler.currentItems); i++){
		var item = ds_list_find_value(obj_itemHandler.currentItems, i);
        var itemData = variable_instance_get(global.items, item);
        
        // Check if itemData exists and has onHit property
        if (variable_instance_exists(global.items, item) && 
            variable_instance_exists(itemData, "onBulletTravel")) {
            var func = itemData.onBulletTravel;
            method_call(func);
        }
	}
}

function loop_onHit(){
	for (var i = 0; i < ds_list_size(obj_itemHandler.currentItems); i++){
		var item = ds_list_find_value(obj_itemHandler.currentItems, i);
        var itemData = variable_instance_get(global.items, item);
        
        // Check if itemData exists and has onHit property
        if (variable_instance_exists(global.items, item) && 
            variable_instance_exists(itemData, "onHit")) {
            var func = itemData.onHit;
            method_call(func);
        }
	}
}

function loop_onFire(fireInfo){
	for (var i = 0; i < ds_list_size(obj_itemHandler.currentItems); i++){
		var item = ds_list_find_value(obj_itemHandler.currentItems, i);
        var itemData = variable_instance_get(global.items, item);
        
        // Check if itemData exists and has onHit property
        if (variable_instance_exists(global.items, item) && 
            variable_instance_exists(itemData, "onFire")) {
            var func = itemData.onFire;
            method_call(func, [fireInfo]);
        }
	}
}

function loop_onTick(){
	for (var i = 0; i < ds_list_size(obj_itemHandler.currentItems); i++){
		var item = ds_list_find_value(obj_itemHandler.currentItems, i);
        var itemData = variable_instance_get(global.items, item);
        
        // Check if itemData exists and has onHit property
        if (variable_instance_exists(global.items, item) && 
            variable_instance_exists(itemData, "onTick")) {
            var func = itemData.onTick;
            method_call(func);
        }
	}
}