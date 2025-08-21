#macro undefinedRoom {specialRoomInfo: createSpecialRoom("none",{requirementFunction : function(arg){return false}, extraArguments: []}, [], undefinedCoords,{min: -1, max: -1}, [], function(arg){return false}, noone)}
#macro startRoom createSpecialRoom("startRoom", {requirementFunction : function(arg){return true}, extraArguments: []}, [], startPoint, {min: 4, max: 4})

function createSpecialRoom(
	roomType = "standard", 
	positionRequirements = {requirementFunction : function(arg){return true}, extraArguments: []}, 
	requiredRoomPartners = [], 
	exactCoord = undefinedCoords,
	doorAmounts= {min: 1, max : 1}, 
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

function createDFloor(specialRoomArray = [], startPoint = [5,5], dimensions = [10,10]){
	
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
		availableCoords : setAllRoomsAvailable(dimensions)
	}
	ds_grid_clear(dfloor.grid, undefinedRoom);
	makeCoordsUnavailable(dfloor.startPoint,dfloor);
	return dfloor
}

function test1(){
	var startPoint = [5,5]
	var dfloor = createDFloor([startRoom], startPoint)
	var specialRooms = [
		createSpecialRoom("item", posRequirement(coordWithinRange,[startPoint, 5,5]))
	]
	print(dfloor.specialRoomArray)
	dfloor.specialRoomArray = array_concat(dfloor.specialRoomArray,specialRooms);
	print(dfloor.specialRoomArray)
	for (var i = 0; i < array_length(dfloor.specialRoomArray); i++){
		specialRoomSetCoords(dfloor.specialRoomArray[i], dfloor)
	}
	return dfloor;
	
}

function posRequirement(reqFunc,extraArgs){
	return {requirementFunction: reqFunc, extraArguments: extraArgs}
}