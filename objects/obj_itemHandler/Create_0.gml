acquiredItems = [];

for (var i = 0; i < array_length(global.triggers); i++){
	variable_instance_set(id,global.triggers[i] + "Items", [])
}

SignalSubscribe(id, "itemAcquired", function(itemId){
	array_push(acquiredItems, itemId)
	var item = global.items[itemId]
	for (var i = 0; i < array_length(item.eventTriggers); i++){
		var eventArray = variable_instance_get(id, item.eventTriggers[i] + "Items")
		array_push(eventArray,itemId)
	}
	if hasOnPickup(itemId){
		triggerEvent(itemId,"onPickup");
		//SignalSend("player: Trigger", getTriggerEvent(itemId,"onPickup"));
	}
})


function subToAllTriggers(){
	for (var i = 0; i < array_length(global.triggers); i++){
		var trigger = global.triggers[i]
		var func = method({
		    trigger_name: trigger,
		    id: id
		}, function(info) {
		    var itemsArray = variable_instance_get(id, trigger_name + "Items")
		    for (var j = 0; j < array_length(itemsArray); j++) {
		        triggerEvent(itemsArray[j], trigger_name, info);
		    }
		});
		SignalSubscribe(id, trigger, func)
	}
}
subToAllTriggers()