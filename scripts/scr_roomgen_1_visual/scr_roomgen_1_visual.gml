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
	for (var i = 0; i < array_length(printArray); i++){
		var arr = printArray[i];
		var str = "|";
		for (var j = 0; j < array_length(arr); j++){
			str = string_concat(str,arr[j],"|");
		}
		print(str);
		print("_________________________________________");
	}
}

function visualizeRoom(dRoom){
	switch (dRoom.specialRoomInfo.roomType){
		case "standard":
			return " s ";
		case "item":
			return " i ";
		case "none":
			return "   "
		case "startRoom":
			return "stp"
	}
}