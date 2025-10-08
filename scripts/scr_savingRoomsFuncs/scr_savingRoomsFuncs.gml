enum closestStringReturns{
	between,
	ahead,
	clone,
}

function saveRoom(roomSaved){
	insertRoomInArr(roomsData, roomSaved);
	print(roomsData);
	saveData(roomsData, fileName);
}
function insertRoomInArr(arr, _room){
	var currentPos = 0;
	if array_length(arr) > 0{
		var closestVal = findClosestString(_room.roomName, " ", arr[0].roomName);
		switch(closestVal){
			case closestStringReturns.clone:{
				print("clone of: " + string(0));
				arr[0] = _room;
			}break;
			case closestStringReturns.between:{
				print("at the start");
				array_insert(arr,0,_room)
			}break;
			case closestStringReturns.ahead:{
					insertRoomInArr_forLoop(arr, _room)
			}break;
		}
	}else{
		var len = array_length(arr)
		arr[len] = _room
	}
}

function insertRoomInArr_forLoop(arr, _room){
	var passed = false;
	for (var i = 1; i < array_length(arr); i++){
		closestVal = findClosestString(_room.roomName, 
			arr[i-1].roomName, 
			arr[i].roomName);
		switch(closestVal){
			case closestStringReturns.between:{
				print("between " + string(i-1) + "and " + string(i));
				array_insert(arr,i,_room)
				passed = true;
				break;
			}break;
			case closestStringReturns.clone:{
				print("clone of: " + string(i));
				arr[i] = _room;
				passed = true;
				break;
			}break;
		}
		if passed{
			break;
		}
	}if !passed{
		
		var len = array_length(arr)
		arr[len] = _room
	}
}
function findClosestString(goalString, prevString, currentString){
	var clone = currentString == goalString
	var between = prevString < goalString && currentString > goalString
	if clone{
		return closestStringReturns.clone
	}else if between{
		return closestStringReturns.between
	}else{
		return closestStringReturns.ahead
	}
	
}

function loadAllRoomData(){
	roomsData = loadData(fileName);
	if array_equals(roomsData, []){
		roomsData = defaultRoomsArray();
		saveData(roomsData, fileName);
	}
}

function defaultRoomsArray(){
	var arr = []
	for (var i = 0; i < array_length(global.roomShapes); i++){
		arr[i] = {roomName:"default_" + global.roomShapes[i],roomShape:global.roomShapes[i],roomType:"standard",roomSubtype: "normal", instances:[], savedRandomsNeeded:0}
	}
	return arr;
}