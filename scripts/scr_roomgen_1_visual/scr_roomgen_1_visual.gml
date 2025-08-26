function visualizeFloor(dFloor){
	var printArray = [];
	var printArrayDoors = [];
	var printArrayHorizontalDoors = [];
	for (var i = 0; i < dFloor.dimensions[0]; i++){
		var xArray = [];
		var xArrayDoors = [];
		var xArrayHoriDoors = [];
		for (var j = 0; j < dFloor.dimensions[1]; j++){
			xArray[j] = visualizeRoom(ds_grid_get(dFloor.grid, j,i));
			xArrayDoors[j] = visualizeDoors(ds_grid_get(dFloor.grid,j,i));
			xArrayHoriDoors[j] = visualizeHoriDoors(ds_grid_get(dFloor.grid,j,i));
		}
		printArray[i] = xArray;
		printArrayDoors[i] = xArrayDoors
		printArrayHorizontalDoors[i] = xArrayHoriDoors;
	}
	print("Floor image:");
	for (var i = 0; i < array_length(printArray)*2; i++){
		var arr = printArray[floor(i/2)];
		
		var horiDoorArr = printArrayHorizontalDoors[floor(i/2)];
		
		var str = "|";
		for (var j = 0; j < array_length(arr); j++){
			if i mod 2 == 1{
				str = string_concat(str, arr[j], horiDoorArr[j]);
			}else{
				var doorLol = "____"
				if i > 0{ 
					doorLol = printArrayDoors[floor(i/2)-1][j]
				}
				str = string_concat(str,doorLol)
			}
		}
		print(str);
	}
	print("_________________________________________");
}

function visualizeRoom(dRoom){
	if roomExists(dRoom){
		switch (dRoom.roomType){
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
function visualizeDoors(dRoom){
	switch (dRoom.doors[3]){
		case true:
			return "_ __"
		case false:
			return "____"
	}
}
function visualizeHoriDoors(dRoom){
	
	switch (dRoom.doors[0]){
		case true:
			return ":"
		case false:
			return "|"
	}
}

