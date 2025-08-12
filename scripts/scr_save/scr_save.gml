enum dataTypes{
	array,
	list
}
function saveData(data, file){
	var _string = json_stringify(data);
	print("string: " + _string);
	var _buffer = buffer_create(string_byte_length(_string) +1, buffer_fixed, 1)
	buffer_write( _buffer, buffer_string, _string);
	buffer_save( _buffer, file);
	buffer_delete(_buffer)
	print("Saved Data " + _string);
	
}

function loadData(fileName, dataType = dataTypes.array){
	var loadedData = noone;
	
	
	if file_exists(fileName){
		var _buffer = buffer_load(fileName);
		var _string = buffer_read(_buffer, buffer_string);
		buffer_delete(_buffer);
		loadedData = json_parse(_string);
	}else{
		switch(dataType){
			case dataTypes.array:{loadedData = [];}break;
			case dataTypes.list:{loadedData = ds_list_create();}break;
		}
	}
	return loadedData;
}