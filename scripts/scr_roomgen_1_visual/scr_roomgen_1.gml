function createSpecialRoom(unlockRequirement = function(){return true}, distFromStart = {min: 0, max: 10}, requiredRoomPartners = [], exactCoord = [-1,-1], unacceptableDoorDirs = [], doorAmounts= {min: 1, max : 1}, roomType = "standard", uniqueRoom = noone){
	var specialRoom = {
		unlockRequirement: unlockRequirement,
		distFromStart: distFromStart,
		requiredRoomPartners: requiredRoomPartners,
		exactCoord: exactCoord,
		unacceptableDoorDirs: unacceptableDoorDirs,
		doorAmounts: doorAmounts,
		roomType : roomType,
		uniqueRoom: uniqueRoom
	}
	return specialRoom
}
function generateSpecialRoom(sRoom, dungeon){
	var coord = sRoom.
}
function specialRoomSetCoord(sRoom){
	if !array_equals(sRoom.exactCoord, [-1,-1]){ 
	}else{
		
	}
}
function coordsWithinGrid(coords,gridDimensions){
	return !(coords[0] >= gridDimensions[0] || coords[0] < 0 || coords[1] >= gridDimensions[1] || coords[1] < 0)
	
}
function createDungeon(specialRoomArray, startPoint = [5,5], dungeonSize = [10,10]){
	var dungeon = {
		specialRoomArray: specialRoomArray,
		startPoint : startPoint,
		dungeonSize : dungeonSize,
	}
	return dungeon
}

function test1(){
	var specialRooms = [
		createSpecialRoom(),
		createSpecialRoom(),
		createSpecialRoom()
	]
	var dungeon = createDungeon
}
