openItems = [];
function open(){
	for (var i = 0; i < array_length(items); i++){
		openItems[i] = summonObject(obj_roomEditor_dropdown, 
		[["last", i == array_length(items)-1], ["value", items[i]], ["x", x], ["y", y+sprite_height+(sprite_height-2)*i]])
	}
}


function close(returnValue){
	for (var i = 0; i < array_length(openItems); i++){
		instance_destroy(openItems[i]);
	}
}