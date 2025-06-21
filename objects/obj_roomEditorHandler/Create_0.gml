global.editorPause = true;


enum editorHandlerStates {
	pickingRoom,
	deleteAreYouSure,
	pickingSize,
	inRoom,
}
chosenRoom = -1;
chosenShape = 0;
startShape = 0;
state = editorHandlerStates.pickingRoom;
availableRooms = [];
instanceRepRealBoyList = ds_list_create();
fileName = "savedRooms.sav"
loadAllRoomData();
maxRooms = array_length(availableRooms);
loadInInstanceReps = false;
currentShape = "normal";

spawnSpawner = false;

function saveRoom(name,rType,rDifficulty, rShape = "normal"){
	
	var allInstances = [];
	for (var i = 0; i < instance_number(obj_roomEditor_instanceRep); i++){
		var cInstance = instance_find(obj_roomEditor_instanceRep, i);
		allInstances[i][0] = ["object", cInstance.object]
		allInstances[i][1] = ["ownEditable", cInstance.ownEditable];
		allInstances[i][2] = ["editable", cInstance.editable];
		allInstances[i][3] = ["x", cInstance.x];
		allInstances[i][4] = ["y", cInstance.y];
		allInstances[i][5] = ["image_xscale", cInstance.image_xscale];
		allInstances[i][6] = ["image_yscale", cInstance.image_yscale];
		for (var j = 0; j < array_length(cInstance.ownEditable); j++){
			allInstances[i][j+7] = cInstance.ownEditable[j]
		}
		
		
	}
	var infoStruct = 
		{	roomName : name,
			instances : allInstances,
			type : rType,
			difficulty : rDifficulty,
			roomShape : rShape,
		 }
	var existingRoom = roomExists(name)
	var len = 0
	if (existingRoom == -1) {
		len = array_length(availableRooms)
		availableRooms[array_length(availableRooms)] = infoStruct;
	} else {
		len = existingRoom;
		availableRooms[existingRoom] = infoStruct;
	}

	
	saveData(availableRooms, fileName)
	return len;
}

function loadAllRoomData(){
	availableRooms = loadData(fileName);
	
}

function roomExists(roomName) {
    for (var i = 0; i < array_length(availableRooms); i++) {
        if (availableRooms[i].roomName == roomName) {
            return i; // Room found
        }
    }
    return -1; // Room not found
}




function getAllRoomStrings(){
	availableRooms[0] = ds_map_find_first(saveData);
	nextUp = ds_map_find_next(saveData, availableRooms[0]);
	for (var i = 1; !is_undefined(nextUp); i++){
		availableRooms[i] = nextUp;
		nextUp = ds_map_find_next(saveData, nextUp);
	}
}
function summonInstanceReps(){
}

function loadInTheInstances(){
	for (var i = 0; i < instance_number(obj_roomEditor_instanceRep); i++){
		var instanceRep = instance_find(obj_roomEditor_instanceRep, i);
		summonObjectArray = [];
		var len = array_length(instanceRep.ownEditable)
		array_copy(summonObjectArray,0,instanceRep.ownEditable,0,len)
			
		summonObjectArray[len] = ["x", instanceRep.x]
		summonObjectArray[len+1] = ["y", instanceRep.y]
		summonObjectArray[len+2] = ["image_xscale", instanceRep.image_xscale]
		summonObjectArray[len+3] = ["image_yscale", instanceRep.image_yscale]
		var realBoy = summonObject(asset_get_index(instanceRep.object), summonObjectArray);
		ds_list_add(instanceRepRealBoyList, realBoy);
	}
}

function inRoomLogic(){
	if obj_inputHandler.space{
		if global.editorPause{
			obj_gameSettingHandler.gameState = gameStates.editorTesting
			global.editorPause = false;
			loadInTheInstances();
		}else{
			obj_gameSettingHandler.gameState = gameStates.editorBuilding
			global.editorPause = true;
			for (var i = 0; i < ds_list_size(instanceRepRealBoyList); i++){
				var inst = ds_list_find_value(instanceRepRealBoyList,0)
				instance_destroy(inst);
				ds_list_delete(instanceRepRealBoyList,0);
			}
			instance_destroy(obj_bullet);
			instance_destroy(obj_enemy)
			instance_destroy(obj_enemy_cannon);
			instance_destroy(obj_enemy_hitbox);
		}
	}

	if !global.editorPause{
	}
}
