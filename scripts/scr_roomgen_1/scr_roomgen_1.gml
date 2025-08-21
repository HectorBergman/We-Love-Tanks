#macro undefinedRoom {specialRoomInfo: createSpecialRoom("none",{requirementFunction : function(arg){return false}, extraArguments: []}, [], undefinedCoords,{min: -1, max: -1}, "normal", [], function(arg){return false}, noone)}
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
	var roomShape = "normal"
	
	if shouldAmalgamate{
		var grid = dfloor.grid
		var XY = getXY(fromDir);
		var ignoreCoords = [coords[0]+XY[0],coords[1]+XY[1]]
		var acceptedIndex = 0;
		var index = 0;
		var acceptedArray = []
		for (var j = -1; j < 2; j++){
			for (var i = -1; i < 2; i++){
				var currentCoords = [i,j]
				//add check for if room can be amalgamated
				if !array_equals(ignoreCoords, currentCoords){
					acceptedArray[acceptedIndex] = index
				}
				index++
			}
		}
	}
	
	//roomName, instances, sanitized, roomShape, roomType, savedRandomsNeeded
	var roomInfo = pickRandomRoomByType(global.roomList, roomType, roomShape)//add something in here for custom rooms
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
function generateRandoms(randomsNeeded){
	var randoms = []
	for (var i = 0; i < randomsNeeded; i++){
		randoms[i] = irandom(4294967295)
	}
	return randoms
}

function createDFloor(specialRoomArray = [], startPoint = [5,5], dimensions = [10,10]){
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
		amalgamOdds : 0.2,
	}
	ds_grid_clear(dfloor.grid, undefinedRoom);
	makeCoordsUnavailable(dfloor.startPoint,dfloor);
	return dfloor
}

function populateDFloor(){
	var startPoint = [5,5]
	var dfloor = createDFloor([startRoom], startPoint)
	var specialRooms = [
		createSpecialRoom("item", posRequirement(coordWithinRange,[startPoint, 3,5]))
	]
	dfloor.specialRoomArray = array_concat(dfloor.specialRoomArray,specialRooms);
	for (var i = 0; i < array_length(dfloor.specialRoomArray); i++){
		specialRoomSetCoords(dfloor.specialRoomArray[i], dfloor)
	}
	generateDFloor(dfloor);
	return dfloor;
	
}

function generateDFloor(dFloor){
	createRoom(dFloor,[0,0], [0,0]);
}

function posRequirement(reqFunc,extraArgs){
	return {requirementFunction: reqFunc, extraArguments: extraArgs}
}