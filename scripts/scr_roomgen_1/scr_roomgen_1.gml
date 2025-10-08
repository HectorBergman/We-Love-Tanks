#macro normalShape ["normal",0]
#macro defaultDoorWeight [-1,-1,-1,-1,-1]

#macro undefinedRoom {doors: [0,0,0,0],  roomType : "none"}
#macro startRoom createSpecialRoom("startRoom", "normal", {requirementFunction : function(arg){return true}, extraArguments: []}, [], startPoint, [0,0,0,0,99])
enum doorValues{
	closed,
	open,
	openToNewStage,
	openToShop,
	unacceptable,
}


function createSpecialRoom(
	roomType = "standard", 
	subType = "normal",
	positionRequirements = {requirementFunction : function(arg){return true}, extraArguments: []}, 
	requiredRoomPartners = [], 
	exactCoords = undefinedCoords,
	doorWeights = defaultDoorWeight,
	roomShape = ["normal",0],
	unacceptableDoorDirs = [], 
	unlockRequirements = function(){return true}, 
	uniqueRoom = noone
){
	
	var specialRoom = {
		roomType: roomType,
		subType : subType,
		positionRequirements: positionRequirements,
		requiredRoomPartners: requiredRoomPartners,
		doorWeights : doorWeights,
		unacceptableDoorDirs: unacceptableDoorDirs,
		unlockRequirements: unlockRequirements,
		uniqueRoom: uniqueRoom,
		exactCoords: exactCoords,
		gridInfo: {isPlaced : false, placedCoords : undefinedCoords}
	}
	return specialRoom
}




function addRoomToGrid(dfloor,sRoom){
	if coordsWithinGrid(sRoom.exactCoords, dfloor.dimensions){
		if !roomExists(ds_grid_get(dfloor.grid, sRoom.exactCoords[0], sRoom.exactCoords[1])){
			updateRoomsGridInfo(dfloor, sRoom, sRoom.exactCoords);
			return sRoom
		}else{
			forceCrash( "addRoomToGrid: room already occupies coords \n" + 
						"Coords: " + string(sRoom.exactCoords));
		}
	}else{
		forceCrash("addRoomToGrid: coords outside grid: \n" + 
					"Coords: " + string(sRoom.exactCoords) + 
					" Outside of dimensions: "  + string(dfloor.dimensions));
	}
}


function createRoom(dfloor, coords, fromDir, sRoom = noone, roomType = noone, forceSkipAmalgam = false, roomSubtype = "normal"){
	var doors = ds_grid_get(dfloor.grid,coords[0],coords[1]).doors
	var doorWeights = dfloor.doorWeights
	if sRoom == noone{
		if roomType == noone{
			roomType = "standard"
		}
	}else{
		for (var i = 0; i < array_length(sRoom.unacceptableDoorDirs); i++){
			var doorDir = sRoom.unacceptableDoorDirs[i]
			changeDoorState(dfloor,coords,doorDir,doorValues.unacceptable);
		}
		if sRoom.doorWeights[0] != -1{
			doorWeights = sRoom.doorWeights;
			print("debug: sRoom.doorWeights: " + string(doorWeights))
		}
		roomType = sRoom.roomType
		forceSkipAmalgam = true;
	}
	var roomShape = ["normal",0]
	var amalgamClaimedCoords = [coords];
	if !forceSkipAmalgam{
		print(dfloor)
		var shouldAmalgamate = random_range(0,1) < dfloor.amalgamOdds
		if shouldAmalgamate{
			roomShape = randomAmalgamateShape(dfloor,fromDir,coords);
			if roomShape[0] != "normal"{
				amalgamClaimedCoords = getAmalgamClaimedCoords(dfloor,roomShape,coords);
			}
		}
	}
	
	//roomName, instances, sanitized, roomShape, roomType, savedRandomsNeeded
	if roomType != "standard"{
		print("roomType: ",roomType);
	}
	var roomInfo = pickRandomRoomByType(global.roomList, roomType, roomShape[0], roomSubtype)//add something in here for custom rooms

	print(roomInfo)
	var preRandoms = [];
	if !is_undefined(roomInfo){
		preRandoms = generateRandoms(roomInfo.savedRandomsNeeded);
	}else{
		roomInfo = { roomName : "", instances: [], sanitized : 1, roomShape : "normal", roomType : "standard", savedRandomsNeeded: 0}
	}
	var fullRoomInfo = {
		specialRoomInfo: sRoom, 
		roomType : roomType,
		roomSubtype : roomSubtype,
		roomInfo : roomInfo,
		doors : doors,
		doorWeights : doorWeights,
		isEdgeRoom : false,
		visited : false,
		cleared : false,
		amalgamClaimedCoords : amalgamClaimedCoords,
		roomShape : roomShape,
		loadedEntities : ds_queue_create(),
		preRandoms : preRandoms,
		coords : coords,
		roomInfo : roomInfo
	}	
	return fullRoomInfo
}

function getAmalgamClaimedCoords(dfloor, shape, coords){
	var roomsNeeded = amalgamAcceptance(shape[0], shape[1]);
	var central = roomsNeeded[shape[1]];
	var amalgamClaimedCoords = [];
	var index = 0;
	for (var i = 0; i < array_length(roomsNeeded); i++){
		if roomsNeeded[i] != -1{
			var XY = getAmalgamXY(central, roomsNeeded[i])
			var newCoord = [coords[0]+XY[0],coords[1]+XY[1]]
			//var newRoom = ds_grid_get(dfloor.grid, newCoord[0],newCoord[1]);
			amalgamClaimedCoords[index] = newCoord;
			index++;
		}
	}
	return amalgamClaimedCoords;
}

function getAmalgamXY(central, goal){
	var lengthDiffFromCenter = goal mod 3 - central mod 3
	var heightDiffFromCenter = floor(goal/3)-floor(central/3)
	
	return [lengthDiffFromCenter,heightDiffFromCenter]
}

function generateRandoms(randomsNeeded){
	var randoms = []
	for (var i = 0; i < randomsNeeded; i++){
		randoms[i] = irandom(4294967295)
	}
	return randoms
}

function coordOccupied(coords,dfloor){
	var _room = ds_grid_get(dfloor.grid, coords[0],coords[1]);
	return roomExists(_room)
}

function roomExists(_room){
	return !(_room.roomType == "none");
}


function posRequirement(reqFunc,extraArgs){
	return {requirementFunction: reqFunc, extraArguments: extraArgs}
}

function createDFloor(
		floorReqs,
		amalgamOdds = 0,
		startPoint = [5,5], 
		dimensions = [10,10], 
		doorWeights = [[0,0,4,2,1], [0,0.5,4,1,1], [0,1,2,2,1], [0,1,4,1,0.5], [0,1.1,0.5,0,0]],
		roomAmountRange = [30,40]){
	global.roomList = loadData("savedRooms2.sav");
	var possibleDoorWeights = generateDoorWeights(doorWeights);
	var dfloor = {
		grid : ds_grid_create(dimensions[0],dimensions[1]),
		specialRoomArray: [],
		startPoint : startPoint,
		dimensions : dimensions,
		availableCoords : setAllRoomsAvailable(dimensions),
		amalgamOdds : amalgamOdds,
		doorWeights : possibleDoorWeights.stage0,
		possibleDoorWeights : possibleDoorWeights,
		edgesArray : [],
		availableRooms : [],
		roomAmountRange : roomAmountRange,
		goalCoords : [],
		roomsQueue : ds_queue_create(),
		queueGrid : ds_grid_create(dimensions[0],dimensions[1]),
		floorNo : -1,
		floorReqs : floorReqs
	}
	for (var j = 0; j < dimensions[1]; j++){
		for (var i = 0; i < dimensions[0]; i++){
			var _room = undefinedRoom;
			_room.coords = [i,j];
			ds_grid_set(dfloor.grid,i,j,_room);
		}
	}
	return dfloor
}

function generateDoorWeights(stagesArray){
	var struct = {}
	var structEntryNameTemplate = "stage"
	for (var i = 0; i < array_length(stagesArray); i++){
		struct_set(struct, structEntryNameTemplate+string(i), stagesArray[i]);
	}
	print("debug2: structDoorWeights: " + string(struct))
	return struct;
}
	
function populateDFloor(floorReqs){
	var startPoint = floorReqs.startPoint
	var dfloor = createDFloor(floorReqs, floorReqs.amalgamOdds,startPoint, floorReqs.floorDimensions, floorReqs.doorWeights, floorReqs.roomAmountRange)
	
	dfloor.specialRoomArray = floorReqs.specialRooms
	initiateSpecialRoom(dfloor,startRoom)
	return dfloor;
}

function floorRequirements(floorDimensions, startPoint, amalgamOdds, doorWeights, roomAmountRange, specialRooms){
	return {floorDimensions : floorDimensions, startPoint : startPoint, 
			amalgamOdds : amalgamOdds, doorWeights : doorWeights, 
			roomAmountRange : roomAmountRange, specialRooms : specialRooms}
}
function initiateSpecialRoom(dfloor,sRoom){
	addRoomToGrid(dfloor, sRoom);
	var newRoom = createRoom(dfloor, sRoom.gridInfo.placedCoords, -1, sRoom, ["normal",0], true)
	ds_grid_set(dfloor.grid, newRoom.coords[0], newRoom.coords[1], newRoom);
}
function destroydfloor(dfloor){
	ds_grid_destroy(dfloor.grid)
	ds_grid_destroy(dfloor.queueGrid)
	ds_queue_destroy(dfloor.roomsQueue)
}
