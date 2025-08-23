#macro normalShape ["normal",0]
#macro defaultDoorWeight [-1,-1,-1,-1,-1]

#macro undefinedRoom {doors: [0,0,0,0],  roomType : "none"}
#macro startRoom createSpecialRoom("startRoom", {requirementFunction : function(arg){return true}, extraArguments: []}, [], startPoint, [0,0,0,0,99])
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
	doorWeights = defaultDoorWeight,
	roomShape = ["normal",0],
	unacceptableDoorDirs = [], 
	unlockRequirements = function(){return true}, 
	uniqueRoom = noone
){
	var specialRoom = {
		roomType: roomType,
		positionRequirements: positionRequirements,
		requiredRoomPartners: requiredRoomPartners,
		doorWeights : doorWeights,
		unacceptableDoorDirs: unacceptableDoorDirs,
		unlockRequirements: unlockRequirements,
		uniqueRoom: uniqueRoom,
		exactCoord: exactCoord,
		gridInfo: {isPlaced : false, placedCoords : undefinedCoords}
	}
	return specialRoom
}


function generateSpecialRoom(dungeon, sRoom){
	var coord = specialRoomGetCoords(dungeon, sRoom);
}

function specialRoomGetCoords(dFloor, sRoom){
	if array_equals(sRoom.exactCoord, undefinedCoords){ 
		var arr = getAllAvailableCoordsFittingReq(dFloor, sRoom.positionRequirements)
		var coord = setRandomCoordInArray(arr, dFloor);
		updateRoomsGridInfo(sRoom, coord);
		return sRoom
		//ds_grid_add(dFloor.grid, coord[0], coord[1], _room);
	}else{
		return addRoomToGrid(dFloor, sRoom);
	}
}



function addRoomToGrid(dFloor,sRoom){
	if coordsWithinGrid(sRoom.exactCoord, dFloor.dimensions){
		if !roomExists(ds_grid_get(dFloor.grid, sRoom.exactCoord[0], sRoom.exactCoord[1])){
			updateRoomsGridInfo(sRoom, sRoom.exactCoord);
			return sRoom
			//ds_grid_add(dFloor.grid, sRoom.exactCoord[0], sRoom.exactCoord[1], {specialRoomInfo: sRoom}) 
		}else{
			forceCrash( "addRoomToGrid: room already occupies coords \n" + 
						"Coords: " + string(sRoom.exactCoord));
		}
	}else{
		forceCrash("addRoomToGrid: coords outside grid: \n" + 
					"Coords: " + string(sRoom.exactCoord) + 
					" Outside of dimensions: "  + string(dFloor.dimensions));
	}
}


function createRoom(dfloor, coords, fromDir, sRoom = noone, roomType = noone, forceSkipAmalgam = false){
	var doors = noDoors
	var doorWeights = dfloor.doorWeights
	if sRoom == noone{
		if roomType == noone{
			roomType = "standard"
		}
	}else{
		for (var i = 0; i < array_length(sRoom.unacceptableDoorDirs); i++){
			var doorDir = sRoom.unacceptableDoorDirs[i]
			doors[doorDir] = doorValues.unacceptable;
		}
		if sRoom.doorWeights[0] != -1{
			doorWeights = sRoom.doorWeights;
		}
		roomType = sRoom.roomType
	}
	var roomShape = ["normal",0]
	if !forceSkipAmalgam{
		var shouldAmalgamate = random_range(0,1) < dfloor.amalgamOdds
		if shouldAmalgamate{
			roomShape = randomAmalgamateShape(dfloor,fromDir,coords);
		}
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
		doorWeights : doorWeights,
		isEdgeRoom : false,
		visited : false,
		cleared : false,
		roomShape : roomShape,
		loadedEntities : [],
		preRandoms : preRandoms,
		coords : coords
	}	
	return fullRoomInfo
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
	return roomExists(_room)
}

function roomExists(_room){
	return !(_room.roomType == "none");
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




function generateStandardRooms(dfloor){
	var grid = dfloor.grid;
	var roomArray = dfloor.specialRoomArray;
	var goalCoords = [];
	for (var i = 0; i < array_length(roomArray); i++){
		if roomArray[i].gridInfo.isPlaced{
			goalCoords[i] = roomArray[i].gridInfo.placedCoords
		}else{
			forceCrash("Room " + roomArray[i] + " is not placed in grid")
		}
	}
	print(goalCoords);
}

function posRequirement(reqFunc,extraArgs){
	return {requirementFunction: reqFunc, extraArguments: extraArgs}
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
		doorWeights : [0,2,7,4,1], //index = amt doors
		roomAmountRange : [30,40],
	}
	ds_grid_clear(dfloor.grid, undefinedRoom);
	return dfloor
}

function populateDFloor(amalgamOdds){
	var startPoint = [5,5]
	var dfloor = createDFloor([], amalgamOdds,startPoint)
	var specialRooms = [
		createSpecialRoom("item", posRequirement(coordsWithinRange,[startPoint, 3,5])),
		createSpecialRoom("boss", posRequirement(coordsWithinRange,[startPoint, 6,7]))
	]
	dfloor.specialRoomArray = array_concat(dfloor.specialRoomArray,specialRooms);
	initiateSpecialRoom(dfloor,startRoom)
	for (var i = 0; i < array_length(dfloor.specialRoomArray); i++){
		var sRoom = dfloor.specialRoomArray[i]
		initiateSpecialRoom(dfloor,sRoom)
		//if crashes cus need specialroominfo fml
	}
	generateStandardRooms(dfloor);
	return dfloor;
	
}
function initiateSpecialRoom(dfloor,sRoom){
	var _room = specialRoomGetCoords(dfloor, sRoom)
	var newRoom = createRoom(dfloor, _room.gridInfo.placedCoords, -1, _room)
	ds_grid_set(dfloor.grid, newRoom.coords[0], newRoom.coords[1], newRoom);
}