var listLength = ds_list_size(activeDelays);
var index = 0;
for (var i = 0; i < listLength; i++){
	var delay = ds_list_find_value(activeDelays,index);
	if delay.timer <= 0{
		delay.func(delay.funcArgs);
		ds_list_delete(activeDelays,index);
	}else{
		delay.timer--
		index++
	}
}