function caseOfAces_onPickup(){
	luck += 4;
}

function find_onPickup(item){
	var itemData = variable_instance_get(global.items, item);
	if variable_instance_exists(global.items, item) && 
       variable_instance_exists(itemData, "onPickup") {
            var func = itemData.onPickup;
            method_call(func);
	}		
}