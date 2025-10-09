function getItemPool(poolName){
	var itemPool = []
	var arrLen = 0;
	for (var i = 0; i < array_length(global.items); i++){
		var item = global.items[i]
		if array_contains(item.itemPools,poolName){
			itemPool[arrLen] = item;
			arrLen++;
		}
	}
	return itemPool;
}

function getItemInfo(itemId){
	return global.items[itemId];
}

function getItemEventTriggers(itemId){
	var item = global.items[itemId]
	var itemTriggers = [];
	for (var i = 0; i < array_length(global.triggers); i++){
		if variable_struct_exists(item,global.triggers[i]){
			itemTriggers[array_length(itemTriggers)] = global.triggers[i];
		}
	}
	return itemTriggers
}