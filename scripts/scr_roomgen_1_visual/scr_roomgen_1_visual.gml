function visualizeFloor(dFloor){
	var printArray = [];
	for (var i = 0; i < dFloor.dimensions[0]; i++){
		var xArray = [];
		for (var j = 0; j < dFloor.dimensions[1]; j++){
			xArray[j] = visualizeRoom(ds_grid_get(dFloor.grid, i,j));
		}
		printArray[i] = xArray;
	}
	print("Floor image:");
	for (var i = 0; i < array_length(printArray)*2; i++){
		var arr = printArray[floor(i/2)];
		var str = "|";
		for (var j = 0; j < array_length(arr); j++){
			if i mod 2 == 1{
				str = string_concat(str,arr[j],"|");
			}else{
				str = string_concat(str,"____")
			}
		}
		print(str);
	}
	print("_________________________________________");
}

function visualizeRoom(dRoom){
	if roomExists(dRoom){
		switch (dRoom.specialRoomInfo.roomType){
			case "standard":
				return " s ";
			case "item":
				return "itm";
			case "boss":
				return "bos";
			case "none":
				return "   "
			case "startRoom":
				return "stp"
		}
	}else{
		return "   "
	}
}