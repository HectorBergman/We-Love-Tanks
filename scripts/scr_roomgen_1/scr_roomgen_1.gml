#macro normalShape ["normal",0]

#macro undefinedRoom {specialRoomInfo: createSpecialRoom("none",{requirementFunction : function(arg){return false}, extraArguments: []}, [], undefinedCoords,{min: -1, max: -1}, normalShape, [], function(arg){return false}, noone)}
#macro startRoom createSpecialRoom("startRoom", {requirementFunction : function(arg){return true}, extraArguments: []}, [], startPoint, {min: 4, max: 4})
enum doorValues{
	closed,
	open,
	openToNewStage,
	openToShop,
	unacceptable,
}


function createSpecialRoom(
	roomType = "standard", 
	positionRequirements = {requirementFunction : function(arg){return true}, extraArguments: []}, 
	requiredRoomPartners = [], 
	exactCoord = undefinedCoords,
	doorAmounts= {min: 1, max : 1}, 
	roomShape = "normal",
	unacceptableDoorDirs = [], 
	unlockRequirements = function(){return true}, 
	uniqueRoom = noone
){
	var specialRoom = {
		roomType: roomType,
		positionRequirements: positionRequirements,
		requiredRoomPartners: requiredRoomPartners,
		doorAmounts: doorAmounts,
		unacceptableDoorDirs: unacceptableDoorDirs,
		unlockRequirements: unlockRequirements,
		uniqueRoom: uniqueRoom,
		exactCoord: exactCoord
	}
	return specialRoom
}
function generateSpecialRoom(sRoom, dungeon){
	var coord = specialRoomSetCoords(sRoom, dungeon);
	
	
}
function specialRoomSetCoords(sRoom, dFloor){
	if array_equals(sRoom.exactCoord, undefinedCoords){ 
		var arr = getAllAvailableCoordsFittingReq(dFloor, sRoom.positionRequirements)
		var coord = setRandomCoordInArray(arr, dFloor);
		var _room = {specialRoomInfo: sRoom};
		ds_grid_add(dFloor.grid, coord[0], coord[1], _room);
	}else{
		if coordsWithinGrid(sRoom.exactCoord, dFloor.dimensions){
			ds_grid_add(dFloor.grid, sRoom.exactCoord[0], sRoom.exactCoord[1], {specialRoomInfo: sRoom}) 
		}else{
			forceCrash("specialRoomSetCoord: coords outside grid: \n" + 
					   "Coords: " + string(sRoom.exactCoord) + 
					   " Outside of dimensions: "  + string(dFloor.dimensions));
		}
	}
}

function createRoom(dfloor, coords, fromDir, sRoom = noone, roomType = noone){
	var doors = noDoors
	if sRoom == noone{
		if roomType == noone{
			roomType = "standard"
		}
	}else{
		for (var i = 0; i < array_length(sRoom.unacceptableDoorDirs); i++){
			var doorDir = sRoom.unacceptableDoorDirs[i]
			doors[doorDir] = doorValues.unacceptable;
		}
		roomType = sRoom.roomType
	}
	
	var shouldAmalgamate = random_range(0,1) < dfloor.amalgamOdds
	var roomShape = ["normal",0]
	if shouldAmalgamate{
		roomShape = randomAmalgamateShape(dfloor,fromDir,coords);
		print(roomShape);
	}
	
	//roomName, instances, sanitized, roomShape, roomType, savedRandomsNeeded
	var roomInfo = pickRandomRoomByType(global.roomList, roomType, roomShape[0])//add something in here for custom rooms
	var preRandoms = [];
	if !is_undefined(roomInfo){
		preRandoms = generateRandoms(roomInfo.savedRandomsNeeded);
	}
	var fullRoomInfo = {
		specialRoomInfo: sRoom, 
		roomType : roomType,
		roomInfo : roomInfo,
		doors : doors,
		visited : false,
		cleared : false,
		roomShape : roomShape,
		loadedEntities : [],
		preRandoms : preRandoms,
	}			
}
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
	print(acceptedAmalgams);
	if array_length(acceptedAmalgams) > 0{
		var randomIndex = irandom(array_length(acceptedAmalgams)-1);
		var shape = acceptedAmalgams[randomIndex];
		return shape;
	}else{
		return ["normal",0];
	}
}
function coordOccupied(coords,dfloor){
	var _room = ds_grid_get(dfloor.grid, coords[0],coords[1]);
	return roomOccupied(_room)
}

function roomOccupied(_room){
	return !(_room.specialRoomInfo.roomType == "none");
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
			print(acceptedRooms)
			print(roomsNeeded);
			isAcceptable = array_contains(acceptedRooms,roomsNeeded[j])
			print(isAcceptable);
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
	print(func);
	return func(shapeVariantNumber);
}
function generateRandoms(randomsNeeded){
	var randoms = []
	for (var i = 0; i < randomsNeeded; i++){
		randoms[i] = irandom(4294967295)
	}
	return randoms
}

function createDFloor(specialRoomArray = [], amalgamOdds = 0,startPoint = [5,5], dimensions = [10,10]){
	global.roomList = loadData("savedRooms2.sav");
	function setAllRoomsAvailable(floorDimensions){
		var availableRooms = ds_map_create();
		for (var i = 0; i < floorDimensions[0]; i++){
			for (var j = 0; j < floorDimensions[1]; j++){
				ds_map_add(availableRooms, getCoordsString([i,j]), true);
			}
		}
		return availableRooms;
	}
	
	var dfloor = {
		grid : ds_grid_create(dimensions[0],dimensions[1]),
		specialRoomArray: specialRoomArray,
		startPoint : startPoint,
		dimensions : dimensions,
		availableCoords : setAllRoomsAvailable(dimensions),
		amalgamOdds : amalgamOdds,
	}
	ds_grid_clear(dfloor.grid, undefinedRoom);
	makeCoordsUnavailable(dfloor.startPoint,dfloor);
	return dfloor
}

function populateDFloor(amalgamOdds){
	var startPoint = [5,5]
	var dfloor = createDFloor([startRoom], amalgamOdds,startPoint)
	var specialRooms = [
		createSpecialRoom("item", posRequirement(coordWithinRange,[startPoint, 3,5]))
	]
	dfloor.specialRoomArray = array_concat(dfloor.specialRoomArray,specialRooms);
	for (var i = 0; i < array_length(dfloor.specialRoomArray); i++){
		specialRoomSetCoords(dfloor.specialRoomArray[i], dfloor)
	}
	createRoom(dfloor,[5,4],3)
	return dfloor;
	
}

function generateDFloor(dFloor){

}

function posRequirement(reqFunc,extraArgs){
	return {requirementFunction: reqFunc, extraArguments: extraArgs}
}