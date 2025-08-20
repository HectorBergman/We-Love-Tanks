x = 0;
y = 0;
fileName = "savedRooms2.sav"
roomsPosition = 0;
roomsData = [];
searchArray = [];
toDrawArray = [];
justexited = false;
menu = noone;
menuOffset = [600,32];
SignalSubscribe(id, "saved room", function(arg){ saveRoom(arg)})
loadAllRoomData();



var shapesArr = createShapeArguments("canHaveShape", global.roomShapes);
var typesArr = createShapeArguments("canBeRoomType", global.roomTypes);
var joinedShapesTypesArr = array_concat([createArgument("roomName", argumentTypes.freetext)],shapesArr,typesArr);
var approvedShapes = [];
var approvedTypes = [];
array_copy(approvedShapes,0,global.roomShapes,0,array_length(global.roomShapes));
array_copy(approvedTypes,0,global.roomTypes,0,array_length(global.roomTypes));
approvedRooms = {approvedShapes : approvedShapes, approvedTypes : approvedTypes, nameReq : ""};

function roomMeetsRequirement(_room){
	return array_contains(approvedRooms.approvedShapes, _room.roomShape)
	&& array_contains(approvedRooms.approvedTypes, _room.roomType)
	&& string_pos(approvedRooms.nameReq, _room.roomName) != 0
}

objectArguments = joinedShapesTypesArr;

function createShapeArguments(_prefix, arr) {
    var args = [];
    for (var i = 0; i < array_length(arr); i++) {
        args[array_length(args)] = createArgument(_prefix + "_" + string(arr[i]), argumentTypes.checkbox, [true]);
    }
    
    return args;
}
instanceArgumentsChoices = [];
setInstanceArgumentsChoices()
toggleMenu();
SignalSubscribe(id, "updateInstance: " + string(id), function(arg){updateSearch(arg)});

function updateSearch(arg){ 
	updateInstanceArgumentChoices(arg[0],arg[1], arg[2])
	var str = objectArguments[arg[1]].argumentName
	if string_last_pos("canHaveShape", str) == 1{
		var roomShape = string_copy(str,14,string_length(str)-13)
		var aprvShapes = approvedRooms.approvedShapes
		var index = array_find_index(aprvShapes, method({shape: roomShape}, function(_val) { return _val == shape; }));
		if index != -1{
			array_delete(aprvShapes,index,1)
		}else{
			aprvShapes[array_length(aprvShapes)] = roomShape
		}
	}else if string_last_pos("canBeRoomType", str) == 1{
		var roomType = string_copy(str,15,string_length(str)-14)
		var aprvTypes = approvedRooms.approvedTypes
		var index = array_find_index(aprvTypes, method({type: roomType}, function(_val) { return _val == type; }));
		if index != -1{
			array_delete(aprvTypes,index,1)
		}else{
			aprvTypes[array_length(aprvTypes)] = roomType
		}
	}else{ //freetext
		approvedRooms.nameReq = arg[2];
	}
	updateSearchArray();
	updateToDrawArray();
}
function updateSearchArray(){//if after a while updating search becomes slow, add code for skipping
							// search given some requirements. like if shape requirement is turned on
						   //  no need to search whole arr, only add those not already in
	searchArray = [];
	var searchArrIndex = 0;
	for (var i = 0; i < array_length(roomsData); i++){
		if roomMeetsRequirement(roomsData[i]){
			searchArray[searchArrIndex] = roomsData[i];
			searchArrIndex++;
		}
	}
}

function findFittingRooms(){
	searchArray = [];
	for (var i = 0; i < roomsData; i++){
		if matchingStringsSoFar("",roomsData[i].roomName){
		}
	}
}

function matchingStringsSoFar(stringCompare,stringBeingCompared){
	var strCompareLen = string_length(stringCompare);
	var strBeingComparedLen = string_length(stringBeingCompared);
	if strCompareLen <= strBeingComparedLen{
		var strBeingComparedSameLen = string_copy(stringBeingCompared,0,strCompareLen)
		if stringCompare == strBeingComparedSameLen{
			return true
		}
	}
	return false;
}

function updateToDrawArray(){
	toDrawArray = [];
	var text = ""
	var roomsDataLen = array_length(searchArray);
	for (var i = roomsPosition; i < roomsPosition+8; i++){
		if i == 0{
			text = "[$eee7e7][scale,1][fnt_coolFont]NEW"
		}else if (i-1) < roomsDataLen{
			text = "[$eee7e7][scale,1][fnt_coolFont]" + searchArray[i-1].roomName;
		}else{
			break;
		}
		toDrawArray[i-roomsPosition] = scribble(text);
	}
}
updateToDrawArray();
enum editorMenuModes {
	selectingRoom,
	editingRoom,
}
enum editorModes {
	editing,
	testing
}
/*case editorModes.editing:{
	}break;
	case editorModes.testing:{
	}break;
*/
summonEditObj = false;
editorMode = editorModes.editing;
menuMode = editorMenuModes.selectingRoom;
function summonMenuObjects(){
	summonObject(obj_editor_pointer);
}
function summonEditorObjects(){
	summonObject(obj_cam);
	summonObject(obj_editor_itemMenu);
	summonObject(obj_editor_player_standIn, [["x", room_width/2], ["y", room_height/2]]);
	summonObject(obj_editor_saveRoomButton, [["x", 0],["y", 0]]);
}

function initiateRoom(){
	//["@ref object(obj_enemySpawner)",[["enemyType","stiffNormal"],["x",560.0],["y",144.0],["image_xscale",1.0],["image_yscale",1.0]]]
	if roomsPosition != 0{
		SignalSend("editor_handler: enterRoom", searchArray[roomsPosition-1]);
		for (var i = 0; i < array_length(searchArray[roomsPosition-1].instances); i++){
			var item = searchArray[roomsPosition-1].instances[i]
			var itemInstanceArray = 
				[["DOindex", item.displayObjIndex],
				["instanceArgumentsChoices", item.instanceArgumentsChoices]]
			addToSummonStruct(item.summonArr, itemInstanceArray);
			summonObject(obj_editor_itemInstance,item.summonArr);
			//searchArray[roomsPosition-1].instances[i] = 
		}
	}
}

function getItemInstanceVars(item){
	var itemInstance = []
	array_copy(itemInstance, 0,item,0,array_length(item))
	var index = array_find_index(item[1], method({type: roomType}, function(_val) { return _val == type; }));
}
function summonItemInstance(item){
	summonObject(item[0], item[1]);
}
function destroyEditorObjects(){
	instance_destroy(obj_cam);
	instance_destroy(obj_editor_itemMenu);
	instance_destroy(obj_editor_player_standIn);
	instance_destroy(obj_editor_saveRoomButton);
	instance_destroy(obj_editor_itemInstance);
}

summonMenuObjects();


function checkForModeSwitchRequest(){
	if obj_inputHandler.space{
		switch (editorMode){
			case editorModes.editing:{
				obj_gameSettingHandler.gameState = gameStates.editorTesting
				SignalSend("editorMode: testing_start")
				SignalSend("itemInstance: unhighlight");
				editorMode = editorModes.testing;
			}break;
			case editorModes.testing:{
				obj_gameSettingHandler.gameState = gameStates.editorBuilding
				SignalSend("editorMode: editing_start")
				editorMode = editorModes.editing;
				instance_destroy(obj_bullet);
				instance_destroy(obj_item);
				instance_destroy(obj_enemy);
				instance_destroy(obj_dollar);
			}break;
		}
		return true;
	}
	return false;
}

function editingRoomLogic(){
	switch (editorMode){
		case editorModes.editing:{
		
		}break;
		case editorModes.testing:{
		
		}break;
	}
}

updateSearchArray();
updateToDrawArray();