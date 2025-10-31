pauseMode = [pM.pauseMenu];
global.newRoom = true;
enterInfo = {
	enteredRoomCoords: [-1,-1], 
	enteredRoomDoor: 0,
	enteredRoomNo: 0,
	enteredRoomDir: [-1,-1],
	enteredRoomFullDoors: []
}
currentDungeon = noone;
currentFloor = noone;
currentRoom = noone;

SignalSubscribe(id, "currentRoom_doors_request", function(){SignalSend("currentRoom_doors_request_response", enterInfo.enteredRoomFullDoors)})
function newDungeon(){
	with (obj_roomHandler_true){
		var startPoint = [4,1]
		var spezRooms = [
			createSpecialRoom("item", "normal",   posRequirement(coordsWithinRangeChebyshev_edgesOnly,[startPoint, 0,6])),
			createSpecialRoom("boss", "elevator", posRequirement(coordsWithinRangeChebyshev_edgesOnly,[startPoint, 0,6]))
		]
		floorReqs = ds_list_create()
		var oneReq = floorRequirements([6,6],startPoint,0.1,[[0,0,4,2,1], [0,0.5,4,1,1], [0,1,2,2,1], [0,1,4,1,0.5], [0,1.1,0.5,0,0]],[4,8],spezRooms)
		SignalSubscribe(id,"roomEntered: general", function(){
			if enterInfo.enteredRoomDoor != -1{
				print("roomentranceno: " , [(enterInfo.enteredRoomDoor+2) mod 4,enterInfo.enteredRoomNo])
				SignalSend("roomEntranceNo", [(enterInfo.enteredRoomDoor+2) mod 4,enterInfo.enteredRoomNo]);
			}
			SignalSend("clearedStatus", currentRoom.cleared);
			loadRoom(currentRoom)
		})
		ds_list_add(floorReqs, oneReq);
		//ds_list_add(floorReqs, oneReq); //2 floors
		currentDungeon = initiateDungeon(floorReqs);
		currentFloor = changeFloor(currentDungeon, 0)
		currentRoom = ds_grid_get(currentFloor.grid, currentFloor.startPoint[0],currentFloor.startPoint[1])
		minimapFullUpdate()
		updateEnterInfo();
	}
}

newDungeon()
SignalSubscribe(id,"transportRoom",function(arg){
	enterNewRoom(arg.roomNo,arg.doorNo,arg.store);
});
SignalSubscribe(id, "Boss defeated", summonDungeonTrans);
SignalSubscribe(id,"newDungeon",  nextLvl)
SignalSubscribe(id,"minimap", minimapFullUpdate)

function minimapFullUpdate(){
	SignalSend("update: currentDungeon", currentDungeon)
	SignalSend("update: currentFloor", currentFloor)
	SignalSend("update: currentRoom", currentRoom)
	SignalSend("update: minimap")
}

function nextLvl(){
	newDungeon()
	SignalSend("transitionStart", {
		transitionType: transitionTypes.newDungeon, 
		transitionStruct : {
						roomNo:0,
						doorNo:-1, 
						movementVector: [0,0],
						store: false
					},
		transitionLengthMult : 3
	})
}

function enterNewRoom(roomNo,doorNo, store = true){
	var dir = getRoomAndDoorVector(roomNo,doorNo)
	if store{
		storePreviousRoom([
			{oIndex: obj_enemy, variables:["x","y","hp","enemyType"]},
			{oIndex: obj_item, variables:["x","y","itemId","state"]},
			{oIndex: obj_dollar, variables:["x","y","scale","type","z","image_angle",
				"rotation","velocity","zSpeed","movementVector","dollarState","coinState",
				"swayX","swayY","timer","movementVectorSway","featherDir","featherVelocity",
				"fakeX","fakeY"]},
			{oIndex: obj_dungeonTrans, variables:["x","y"]},
			{oIndex: obj_boss, variables:["x","y","hp","phase","type","movementVector"]}
		]);
		checkCleared()
	}
	enterInfo.enteredRoomDoor = doorNo;
	currentRoom.visited = true;
	//var extraDiff = getRoomDiff(enterInfo.enteredRoomNo,roomNo);
	//enterInfo.enteredRoomDoor = doorNo;
	var newCoords = [currentRoom.coords[0]+dir[0], currentRoom.coords[1]+dir[1]]//+extraDiff[0],currentRoom[1]+yDirection+extraDiff[1]];
	var newRoom = ds_grid_get(currentFloor.grid, newCoords[0], newCoords[1])
	if inRange(newCoords[0], 0, currentFloor.dimensions[0]) && inRange(newCoords[1], 0, currentFloor.dimensions[1]) && !is_undefined(newRoom) && newRoom != noone{
		//obj_currentRoomHandler.roomDoors = room_getAllDoors(newRoom);
		gotoRoom(newRoom);
		currentRoom = newRoom
		//enterInfo.enteredRoomNo = newRoom.roomShapeInfo.roomNo
	}else{
		currentRoom = undefinedCoords;
		forceCrash("roomOutsideBoundaries");
		//todo: add error room
	}
	SignalSend("update: currentRoom", currentRoom)
	SignalSend("update: minimap")
	
	updateEnterInfo()
	//isNewRoom = true;
}

function updateEnterInfo(){
	enterInfo.enteredRoomNo = getRoomNo(currentRoom);
	enterInfo.enteredRoomFullDoors = getAllDoors(coord_sort_fill(currentRoom.amalgamClaimedCoords));
}

function getRoomVector(_from, _to) {
    var grid_width = 2;

    var from_x = _from mod grid_width;
    var from_y = floor(_from / grid_width);

    var to_x = _to mod grid_width;
    var to_y = floor(_to / grid_width);

    return [to_x - from_x, to_y - from_y];
}

function getRoomAndDoorVector(roomNo,doorNo){
	if roomNo == -1 || doorNo == -1{
		return [0,0]
	}
	var roomDiff = getRoomVector(enterInfo.enteredRoomNo,roomNo)
	var doorDiff = getXY(doorNo)
	var roomAndDoorDiff = [roomDiff[0]+doorDiff[0],roomDiff[1]+doorDiff[1]]
	return roomAndDoorDiff;
}

/// @function getRoomNo(_room)
/// @desc Returns the grid index of this room within a minimum 2x2 area.
function getRoomNo(_room) {
    var coordsArray = _room.amalgamClaimedCoords;

    // --- Step 1: Determine grid bounds
    var min_x = coordsArray[0][0];
    var min_y = coordsArray[0][1];
    var max_x = coordsArray[0][0];
    var max_y = coordsArray[0][1];
    
    for (var i = 1; i < array_length(coordsArray); i++) {
        var c = coordsArray[i];
        if (c[0] < min_x) min_x = c[0];
        if (c[1] < min_y) min_y = c[1];
        if (c[0] > max_x) max_x = c[0];
        if (c[1] > max_y) max_y = c[1];
    }

    // --- Step 2: Enforce minimum 2x2 grid bounds
    var grid_width  = (max_x - min_x + 1);
    var grid_height = (max_y - min_y + 1);

    if (grid_width < 2) {
        max_x += (2 - grid_width);
        grid_width = 2;
    }
    if (grid_height < 2) {
        max_y += (2 - grid_height);
        grid_height = 2;
    }

    // --- Step 3: Compute index within the enforced grid
    var my_x = _room.coords[0];
    var my_y = _room.coords[1];

    var index = (my_y - min_y) * grid_width + (my_x - min_x);

    return index;
}


//sorts arrays in 2x2 grid
function coord_sort(coordsArray){
	array_sort(coordsArray, function(a, b) {
		
	    if (a[1] < b[1]) return -1;
	    if (a[1] > b[1]) return 1;
	    
	    if (a[0] < b[0]) return -1;
	    if (a[0] > b[0]) return 1;

	    return 0;
	});
}

function gotoRoom(_room){
	print("wegotoroom");
	room_goto(asset_get_index("rm_roomTemplate_" + _room.roomShape[0]));
}

function storePreviousRoom(objectIndexes){
	var cRoom = ds_grid_get(currentFloor.grid, currentRoom.coords[0], currentRoom.coords[1])
	for (var i = 0; i < array_length(objectIndexes); i++){
		for (var j = 0; j < instance_number(objectIndexes[i].oIndex); j++){
			var currentInst = instance_find(objectIndexes[i].oIndex,j);
			storeInstance(cRoom.loadedEntities, currentInst, objectIndexes[i].variables);
		}
	}
}

function storeInstance(queue, instance, variables){
	var summonArray = [];
	for (var i = 0; i < array_length(variables); i++){
		summonArray[i] = [variables[i], variable_instance_get(instance, variables[i])]
	}
	summonArray[array_length(variables)] = ["oldInstance", true]
	var newEntry =  {objIndex:instance.object_index,
		summonArray: summonArray
	}
	ds_queue_enqueue(queue,newEntry);
}
function loadRoom(newRoom){
	var insts = newRoom.loadedEntities
	var queueLen = ds_queue_size(insts)
	for (var i = 0; i < queueLen; i++){
		var instance = ds_queue_dequeue(insts)
		summonObject(instance.objIndex, instance.summonArray);
	}
	for (var i = 0; i < array_length(newRoom.roomInfo.instances); i++){
		var instance = newRoom.roomInfo.instances[i];
		summonObject(instance.objectIndex, instance.summonArray);
	}
	
	SignalSend("doors:", [enterInfo.enteredRoomFullDoors, currentRoom.cleared])

}
function getAllDoors(coordArr){
	print("getAllDoors: ", coordArr);
	var newArr = []
	for (var i = 0; i < array_length(coordArr); i++){
		if !array_equals([-1,-1],coordArr[i]){
			newArr[i] = ds_grid_get(currentFloor.grid,coordArr[i][0],coordArr[i][1]).doors
		}else{
			newArr[i] = [-1,-1,-1,-1]
		}
	}
	print("result: ", newArr);
	return newArr
}
/// @function coord_sort_fill(coordsArray)
/// @desc Sorts coordinates into grid order and fills missing slots with [-1,-1].
function coord_sort_fill(coordsArray) {
    // --- Step 1: Sort existing coordinates (row-major order: y then x)
    array_sort(coordsArray, function(a, b) {
        if (a[1] < b[1]) return -1;
        if (a[1] > b[1]) return 1;
        if (a[0] < b[0]) return -1;
        if (a[0] > b[0]) return 1;
        return 0;
    });

    // --- Step 2: Find grid bounds (assume coordsArray length >= 1)
    var min_x = coordsArray[0][0];
    var max_x = coordsArray[0][0];
    var min_y = coordsArray[0][1];
    var max_y = coordsArray[0][1];

    for (var i = 1; i < array_length(coordsArray); i++) {
        var c = coordsArray[i];
        if (c[0] < min_x) min_x = c[0];
        if (c[0] > max_x) max_x = c[0];
        if (c[1] < min_y) min_y = c[1];
        if (c[1] > max_y) max_y = c[1];
    }

    // --- Ensure the grid is at least 2x2
    var grid_width  = (max_x - min_x + 1);
    var grid_height = (max_y - min_y + 1);

    if (grid_width < 2) {
        // expand to the right to make width 2
        max_x += (2 - grid_width);
        grid_width = 2;
    }
    if (grid_height < 2) {
        // expand downward to make height 2
        max_y += (2 - grid_height);
        grid_height = 2;
    }

    // --- Step 3: Build the filled grid (row-major order: y outer, x inner)
    var filled = [];
    for (var j = min_y; j <= max_y; j++) {
        for (var k = min_x; k <= max_x; k++) {
            var found = false;
            for (var i = 0; i < array_length(coordsArray); i++) {
                var c = coordsArray[i];
                if (c[0] == k && c[1] == j) {
                    array_push(filled, c);
                    found = true;
                    break;
                }
            }
            if (!found) {
                array_push(filled, [-1, -1]); // placeholder
            }
        }
    }

	print("postFill: ", filled);
    return filled;
}

function checkCleared(){
	ds_grid_get(currentFloor.grid, currentRoom.coords[0], currentRoom.coords[1]).cleared = 
		instance_number(obj_enemy) == 0 && 
		instance_number(obj_enemySpawner) == 0 &&
		instance_number(obj_bossSpawner) == 0 &&
		instance_number(obj_boss) == 0
}

function changeFloor(currentDungeon, floorNo){
	for (var i = 0; i < ds_list_size(currentDungeon.floors); i++){
		print(ds_list_find_value(currentDungeon.floors,i));
	}
	var currentFloorNo = floorNo
	var currentFloor = ds_list_find_value(currentDungeon.floors, currentFloorNo)
	return currentFloor;
}
function lol(changeDiff){
	if inRange(currentFloorNo+floorDiff, 0, currentDungeon.floorCount){
		reachFloor(currentFloorNo+floorDiff)
	}else{
		forceCrash("floorNo outside of available floors: " +string(currentFloorNo+floorDiff))
	}
}
SignalSend("getTransitionFunction")

function summonDungeonTrans(){
	summonObject(obj_dungeonTrans, [["x", room_width/2],["y",room_height/2]])
}
//SignalSubscribe(id, "roomEntered: newRoom", roomEnterLogic);
