function visualizeFloor(dFloor){
	print("visFloor called");
	var printArray = [];
	var printArrayDoors = [];
	var printArrayHorizontalDoors = [];
	print(dFloor);
	for (var i = 0; i < dFloor.dimensions[0]; i++){
		var xArray = [];
		var xArrayDoors = [];
		var xArrayHoriDoors = [];
		for (var j = 0; j < dFloor.dimensions[1]; j++){
			var _room = ds_grid_get(dFloor.grid, j,i)
			xArray[j] = visualizeRoom(_room);
			xArrayDoors[j] = visualizeDoors(_room);
			xArrayHoriDoors[j] = visualizeHoriDoors(_room);
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
		switch (dRoom.roomShape[0]) {
		    case "normal":
		        return "nor"
		    case "giant":
		        return "gia"
		    case "long":
		        return "lon"
		    case "tall":
		        return "tal"
		    case "topLeftAbsent":
		        return "tla"
		    case "topRightAbsent":
		        return "tra"
		    case "bottomLeftAbsent":
		        return "bla"
		    case "bottomRightAbsent":
		        return "bra"
		    default:
		        return "fuc"
		}
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
			case "claimed":
				print(dRoom.coords);
				forceCrash("Room remains claimed");
		}
	}else{
		return "   "
	}
}
function visualizeDoors(dRoom){
	if variable_struct_exists(dRoom, "amalgamClaimedCoords") &&
	arrayContainsArray(dRoom.amalgamClaimedCoords, [dRoom.coords[0],dRoom.coords[1]+1]){
		return "   _"
	}
	switch (dRoom.doors[3]){
		case true:
		
			return "_ __"
		case false:
			return "____"
	}
}
function visualizeHoriDoors(dRoom){
	if variable_struct_exists(dRoom, "amalgamClaimedCoords") &&
	arrayContainsArray(dRoom.amalgamClaimedCoords, [dRoom.coords[0]+1,dRoom.coords[1]]){
		return " "
	}
	switch (dRoom.doors[0]){
		case true:
			return ":"
		case false:
			return "|"
	}
}

