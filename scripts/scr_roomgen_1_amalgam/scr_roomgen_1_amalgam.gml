function randomAmalgamateShape(dfloor, fromDir, coords){
	var grid = dfloor.grid
	var XY = getXY(fromDir);
	var ignoreCoords = [coords[0]+XY[0],coords[1]+XY[1]]
	var acceptedIndex = 0;
	var index = 0;
	var acceptedArray = []
	for (var j = -1; j < 2; j++){
		for (var i = -1; i < 2; i++){
			var currentCoords = [coords[0]+i,coords[1]+j]
			//add check for if room can be amalgamated
			if !array_equals(ignoreCoords, currentCoords) && !coordOccupied(currentCoords, dfloor){
				acceptedArray[acceptedIndex] = index
				acceptedIndex++
			}
			index++
		}
	}
	var acceptedAmalgams = getAcceptedAmalgams(acceptedArray);
	if array_length(acceptedAmalgams) > 0{
		var randomIndex = irandom(array_length(acceptedAmalgams)-1);
		var shape = acceptedAmalgams[randomIndex];
		return shape;
	}else{
		return ["normal",0];
	}
}

function getAcceptedAmalgams(acceptedRooms){
	var potentialAmalgams = [
		["long", 0],
		["long", 1],
		["tall", 0],
		["tall", 2],
		["topLeftAbsent", 1],
		["topLeftAbsent", 2],
		["topLeftAbsent", 3],
		["topRightAbsent", 0],
		["topRightAbsent", 2],
		["topRightAbsent", 3],
		["bottomLeftAbsent", 0],
		["bottomLeftAbsent", 1],
		["bottomLeftAbsent", 3],
		["bottomRightAbsent", 0],
		["bottomRightAbsent", 1],
		["bottomRightAbsent", 2],
		["giant", 0],
		["giant", 1],
		["giant", 2],
		["giant", 3]
	]
	var acceptedAmalgams = [];
	for (var i = 0; i < array_length(potentialAmalgams); i++){
		var roomsNeeded = amalgamAcceptance(potentialAmalgams[i][0], potentialAmalgams[i][1]);
		var isAcceptable = true;
		for (var j = 0; j < array_length(roomsNeeded); j++){

			isAcceptable = array_contains(acceptedRooms,roomsNeeded[j])

			if !isAcceptable{
				break
			}
		}
		if isAcceptable{
			acceptedAmalgams[array_length(acceptedAmalgams)] = potentialAmalgams[i]
		}
	}
	return acceptedAmalgams
}


function amalgamAcceptance(shape, shapeVariantNumber){
	var func = asset_get_index("amalgamAcceptance_" + shape);
	return func(shapeVariantNumber);
}



function amalgamAcceptance_long(shapeVariantNumber){
	switch (shapeVariantNumber){
		case 0:
			return [4,5]
		case 1:
			return [3,4]
		default:
			forceCrash(string(shapeVariantNumber) + "is not a valid variant number for shape long")
			
	}
}
function amalgamAcceptance_tall(shapeVariantNumber){
	switch (shapeVariantNumber){
		case 0:
			return [4,7]
		case 2:
			return [1,4]
		default:
			forceCrash(string(shapeVariantNumber) + "is not a valid variant number for shape tall")
	}
}
function amalgamAcceptance_topLeftAbsent(shapeVariantNumber){
	switch (shapeVariantNumber){
		case 1:
			return [4,6,7]
		case 2:
			return [2,4,5]
		case 3:
			return [1,3,4]
		default:
			forceCrash(string(shapeVariantNumber) + "is not a valid variant number for shape topLeftAbsent")
	}
}
function amalgamAcceptance_topRightAbsent(shapeVariantNumber){
	switch (shapeVariantNumber){
		case 0:
			return [4,7,8]
		case 2:
			return [1,4,5]
		case 3:
			return [0,3,4]
		default:
			forceCrash(string(shapeVariantNumber) + "is not a valid variant number for shape topLeftAbsent")
	}
}

function amalgamAcceptance_bottomLeftAbsent(shapeVariantNumber){
	switch (shapeVariantNumber){
		case 0:
			return [4,5,8]
		case 1:
			return [3,4,7]
		case 3:
			return [0,1,4]
		default:
			forceCrash(string(shapeVariantNumber) + "is not a valid variant number for shape topLeftAbsent")
	}
}

function amalgamAcceptance_bottomRightAbsent(shapeVariantNumber){
	switch (shapeVariantNumber){
		case 0:
			return [4,5,7]
		case 1:
			return [3,4,6]
		case 2:
			return [1,2,4]
		default:
			forceCrash(string(shapeVariantNumber) + "is not a valid variant number for shape topLeftAbsent")
	}
}
function amalgamAcceptance_giant(shapeVariantNumber){
	switch (shapeVariantNumber){
		case 0:
			return [4,5,7,8]
		case 1:
			return [3,4,6,7]
		case 2:
			return [1,2,4,5]
		case 3:
			return [0,1,3,4]
		default:
			forceCrash(string(shapeVariantNumber) + "is not a valid variant number for shape topLeftAbsent")
	}
}
