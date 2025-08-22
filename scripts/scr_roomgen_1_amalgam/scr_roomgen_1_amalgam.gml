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