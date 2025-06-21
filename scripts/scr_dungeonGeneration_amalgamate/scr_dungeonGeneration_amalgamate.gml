
function random_amalgamate(){
	var len = ds_list_size(roomCoordsList);
	print(roomCoordsList);
	var randomInt = irandom(len-1);
	var chosenRoomCoords = ds_list_find_value(roomCoordsList,randomInt)
	print(chosenRoomCoords);
	print("hello");
	var _room = ds_grid_get(dungeonGrid, chosenRoomCoords[0], chosenRoomCoords[1]);
	if _room.amalgamated{
		return "amalgamatefailure";
	}
	var shapeAndOr = chooseShapeAndOrientation(chosenRoomCoords);
	if shapeAndOr[0] == -229{
		return "amalgamatefailure";
	}
	var startDir = amalgamate_getStart(chosenRoomCoords,shapeAndOr[1]);
	var startPoint = [chosenRoomCoords[0]+startDir[0],chosenRoomCoords[1]+startDir[1]]
	
	var rooms = amalgamate_getSteps(startPoint,shapeAndOr[0]);
	print(rooms);
	print(shapeAndOr[0]);
	print(global.roomShapes[shapeAndOr[0]]);
	room_amalgamate(rooms,global.roomShapes[shapeAndOr[0]])
	return "amalgamatesuccess";
	
	
}


function room_amalgamate(roomsArray,roomShape){
	if roomShape == global.roomShapes[0]{
		//maybe error here
		return;
	}else if roomShape == global.roomShapes[1] || roomShape == global.roomShapes[2]{
		var arrLen = array_length(roomsArray)
		if arrLen == 2{
			room_loopAmalgamate(roomsArray,roomShape,arrLen);
		}else{
			//error
		}
		
	}else if 
	(roomShape == global.roomShapes[3] || roomShape == global.roomShapes[4] || 
	 roomShape == global.roomShapes[5] || roomShape == global.roomShapes[6])
	{
		var arrLen = array_length(roomsArray)
		if arrLen == 3{
			room_loopAmalgamate(roomsArray,roomShape,arrLen);
		}else{
			//error
		}
	}else if roomShape ==global.roomShapes[7]{
		var arrLen = array_length(roomsArray)
		if arrLen == 4{
			room_loopAmalgamate(roomsArray,roomShape,arrLen);
		}else{
			//error
		}
	}else{
		//fo sho error here
		return;
	}
}
function room_loopAmalgamate(roomsArray,roomShape, arrLen){
	print(arrLen);
	var roomShapeTable = getRoomShapeTable(roomShape);
	print("amalgam");
	var hasEdge = false;
	for (var i = 0; i < arrLen; i++){
		print(roomsArray[i][0])
		print(roomsArray[i][1]);
		print(roomShape);
		if ds_grid_get(dungeonGrid,roomsArray[i][0],roomsArray[i][1]).edge{
			hasEdge = true;
			break;
		}
	}
	var _room = pickRandomRoomByType(global.roomList,"standard",roomShape);
	print(_room);
	var fakeI = 0;
	for (var i = 0; i < 4; i++){
		if roomShapeTable[i] == 0{
			array_insert(roomsArray, i, [-229,-229]);
			continue;
		}
		var curRoom = ds_grid_get(dungeonGrid,roomsArray[i][0],roomsArray[i][1]);
		
		curRoom.roomShapeInfo = 
		{roomNo: i,leftOverEntities: curRoom.roomShapeInfo.leftOverEntities,
			roommates: roomsArray}
		curRoom.roomShape = roomShape;
		curRoom.edge = hasEdge;
		curRoom._room = _room
		curRoom.amalgamated = true;
		ds_grid_set(dungeonGrid,roomsArray[i][0],roomsArray[i][1], curRoom);
		fakeI++
	}
	for (var i = 0; i < array_length(roomsArray); i++){
		if roomsArray[i] != [-229,-229]{
			list_delete_by_array(roomCoordsList, roomsArray[i]);
		}
	}
}

function chooseShapeAndOrientation(coords){
	var neighbours = room_getAmalgamateCandidates(coords);
	var legalShapes = determineLegalShapes(neighbours);
	print("legalshapes:");
	print(legalShapes);
	var shapesArrays = legalShapes[0]
	var totalLegalShapes = legalShapes[1]
	var trueShapes = get_true_indexes(totalLegalShapes);
	if array_length(trueShapes)-1 < 0{
		return[-229,-229]
	}
	var chosenShape = trueShapes[irandom(array_length(trueShapes)-1)];
	var hasShape = [];
	var index = 0;
	for (var i = 0; i < array_length(shapesArrays); i++){
		if shapesArrays[i][chosenShape]{
			hasShape[index] = i;
			index++;
		}
	}
	print(hasShape);
	print(array_length(hasShape));
	var randomNo = irandom(array_length(hasShape)-1)
	print(randomNo);
	var chosenPos = hasShape[randomNo];
	print("thisPos");
	print(chosenPos);
	return [chosenShape,chosenPos]
}
function get_true_indexes(_array) {
    var result = array_create(0);
    for (var i = 0; i < array_length(_array); i++) {
        if (_array[i]) { // this will evaluate to true for boolean true
            result[array_length(result)] = i;
        }
    }
    return result;
}

function room_getAmalgamateCandidates(coords){
	print("weee");
	var index = 0;
	var neighbourArr = [];
	print(coords);
	for (var i = -1; i < 2; i++){
		for (var j = -1; j < 2; j++){
			var neighbour = ds_grid_get(dungeonGrid,coords[0]+i,coords[1]+j);
			print(neighbour);
			if neighbour != noone && !is_undefined(neighbour) && !(coords[0]+i == 5 && coords[1]+j == 5) && !neighbour.amalgamated{
				//if room exists and is not home room, its ok to amalgamate
				neighbourArr[index] = true
			}else{
				print("coord not allowed: [" + string(coords[0]+i) + "," + string(coords[1]+j) + "]");
				neighbourArr[index] = false
			}
			index++
		}
	}
	return neighbourArr;
}
function amalgamate_getStart(middleCoords,number){
	var action = [0,0];
	if number == 0{
		action = [-1,-1]
	}else if number == 1{
		action = [-1,0]
	}else if number == 2{
		action = [-1,1]
	}else if number == 3{
		action = [0,-1]
	}else if number == 4{
		action = [0,0]
	}else if number == 5{
		action = [0,1]
	}else if number == 6{
		action = [1,-1]
	}else if number == 7{
		action = [1,0]
	}else if number == 8{
		action = [1,1]
	}
	return action;
}
function amalgamate_getSteps(startCoords, shape){
	if shape == 0{
		return [startCoords];
	}else if shape == 1{
		return [startCoords, [startCoords[0]+1, startCoords[1]]];
	}else if shape == 2{
		return [startCoords, [startCoords[0], startCoords[1]+1]];
	}else if shape == 3{
		return [[startCoords[0]+1,startCoords[1]], [startCoords[0],startCoords[1]+1],[startCoords[0]+1,startCoords[1]+1]];
	}else if shape == 4{
		return [startCoords, [startCoords[0], startCoords[1]+1],[startCoords[0]+1,startCoords[1]+1]];
	}else if shape == 5{
		return [startCoords, [startCoords[0]+1, startCoords[1]],[startCoords[0]+1,startCoords[1]+1]];
	}else if shape == 6{
		return [startCoords, [startCoords[0]+1, startCoords[1]],[startCoords[0],startCoords[1]+1]];
	}else if shape == 7{
		return [startCoords, [startCoords[0]+1, startCoords[1]],[startCoords[0],startCoords[1]+1],[startCoords[0]+1,startCoords[1]+1]];
	}else{
		return [[-229,-229]];
	}
}
//	0 = "normal",1 ="long",2 ="tall",3 = "topLeftAbsent",4 = "topRightAbsent",
//5 = "bottomLeftAbsent",6 = "bottomRightAbsent", 7 = "giant",
function determineLegalShapes(neighbourArr){
	
	//0 3 6
	//1 4 7
	//2 5 8
	print("determineLegalShape");
	var totalLegality = [false,false,false,false,false,false,false,false];
	var fullArr = [];
	for (var i = 0; i < 5; i++){
		if i == 2{
			fullArr[i] = [false,false,false,false,false,false,false,false];
			continue;
		}
		var arr = getCorrespondingNumbers(i);
		var legalityArray = [false,false,false,false,false,false,false,false];
		for (var j = 1; j < 8; j++){
			var relIndex = getRelevantIndexes(j) //get an array of numbers corresponding to the rooms
												 //that need to be available to get that shape
			var relevant = getRelevantNumbers(arr,relIndex); //takes the numbers given from getCorr.Numb.
															 //and removes the ones not relevant for the 
															 //relindex shape
			var isAcceptable = true;
			print("neighbourArr:");
			print(neighbourArr);
			print("contenders:")
			print(relevant);
			for (var k = 0; k < array_length(relevant); k++){
				print("contender:");
				print(relevant[k])
				if neighbourArr[relevant[k]] == 0{
					isAcceptable = false;
					print("failed");
					break;
				}
				//todo add something here to detect rooms that already are amalgamated
				print("passed");
			}
			legalityArray[j] = isAcceptable;
			if isAcceptable{
				totalLegality[j] = true;
			}
			
		}
		fullArr[i] = legalityArray;
	}	
	return [fullArr, totalLegality];
}

function getRelevantNumbers(numbers,indexes){
	var arr = [];
	var index = 0;
	for (var i = 0; i < 4; i++){
		if indexes[i]{
			arr[index] = numbers[i];
			index++
		}
	}
	return arr;
}
function getCorrespondingNumbers(number){
	return [number, number+3, number+1,number+4];
}
function getRelevantIndexes(index){
	var returnArray = [true,false,false,false]
	if index == 0{
	}else if index == 1{
		returnArray[1] = true;
	}else if index == 2{
		returnArray[2] = true;
	}else if index == 3{
		returnArray = [false,true,true,true]
	}else if index == 4{
		returnArray[2] = true;
		returnArray[3] = true;
	}else if index == 5{
		returnArray[1] = true;
		returnArray[3] = true;
	}else if index == 6{
		returnArray[1] = true;
		returnArray[2] = true;
	}else if index == 7{
		returnArray = [true,true,true,true]
	}
	return returnArray
		
}