reHandler = noone;
reDragger = noone;
reMenu = noone;
rePlayer = noone;
rePF = noone;
reItemHand = noone;
reCrosshair = noone;
reCam = noone;
reParticle = noone;

reSummoned = false;
reSummon = false; 


inGame = {
}


function createSummonStructStruct(summonStructStruct){
	var newStruct = {}
	for (var i = 0; i < array_length(summonStructStruct); i++){
		var name = object_get_name(summonStructStruct[i][0].object_index)
		var noobj_name = string_delete(name, 1, 4);
		variable_struct_set(newStruct, noobj_name, summonStructStruct[i]);
	}
	return newStruct;
}

function summonAllFromStruct(struct,instanceStruct){
	var keys = variable_struct_get_names(struct);

	for (var i = 0; i < array_length(keys); i++) {
		var key = keys[i];
		var value = variable_struct_get(struct, key);
		variable_struct_set(instanceStruct, keys[i], summonObject(value[0],value[1]));
	}
}
var stru = createSummonStructStruct("inGame",[[obj_cam,[]],[obj_delayHandler,[]],[obj_itemHandler,[]]])
summonAllFromStruct(stru,inGame)

normCam = noone;
normItemHand = noone;
normCurrRoom = noone;
normPF = noone;
normCrossHair = noone;
normPlayer = noone;
normMinimapHand = noone;
normMoneyHand = noone;
normRH = noone;
normLevelH = noone;
normParticle = noone;
normTransition = noone;
normTimerHand = noone;

alwaysParticle = noone;

normSummoned = false;
lethimcook = false;
function prepSummon(){
	normRH = summonObject(obj_roomHandler_true);
	lethimcook = true;
	normSummoned = true;
}
function always_summon(){
	alwaysParticle = summonObject(obj_particleHandler);
}

function summon_inGame() {
	inGame.cam = summonObject(obj_cam);
	inGame.timerHand = summonObject(obj_delayHandler);
	inGame.itemHand = summonObject(obj_itemHandler);
}
function dismantle_struct(name){
	var struct = variable_instance_get(id, name)
	var keys = variable_struct_get_names(struct);
	
	// Iterate through them
	for (var i = 0; i < array_length(keys); i++) {
		var key = keys[i];
		var value = variable_struct_get(struct, key);
		instance_destroy(value);
		variable_struct_set(struct, key, noone);
	}
}
function normal_summon(){
	normPF = summonObject(obj_pathFinderHandler);
	//normItemHand = summonObject(obj_itemHandler);
	normPlayer = summonObject(obj_player, [["x", 960/2], ["y", 540/2]]);
	normCrossHair = summonObject(obj_crosshair, [["x", 960/2], ["y", 540/2]]);
	//normCurrRoom = summonObject(obj_currentRoomHandler);
	normMinimapHand = summonObject(obj_minimapHandler_true);
	normLevelH = summonObject(obj_levelHandler);
	
	normTransition = summonObject(obj_transitionHandler);
	normSummoned = true;
}
function normal_delete(){
	instance_destroy(normPlayer);
	instance_destroy(normPF);
	instance_destroy(normCam);
	instance_destroy(normCrossHair);
	instance_destroy(normMinimapHand);
	instance_destroy(normCurrRoom);
	instance_destroy(normTimerHand);
	//instance_destroy(normItemHand);
	normSummoned = false;
}
function editorHandlers_summon(){
	if instance_number(obj_roomEditor_dragger) == 0{reDragger = summonObject(obj_roomEditor_dragger);}
	if instance_number(obj_roomEditor_menu) == 0{reMenu = summonObject(obj_roomEditor_menu, [["x", 816], ["y", 0]]);}
	if instance_number(obj_player) == 0{rePlayer = summonObject(obj_player, [["x", 960/2], ["y", 540/2]]);}
	if instance_number(obj_pathFinderHandler) == 0{rePF = summonObject(obj_pathFinderHandler);}
	if instance_number(obj_itemHandler) == 0{reItemHand = summonObject(obj_itemHandler);}
	if instance_number(obj_button) == 0{summonObject(obj_button, [["x", 0], ["y", 0],["action", 3]]);}
	if instance_number(obj_crosshair) == 0{reCrosshair = summonObject(obj_crosshair, [["x", 960/2], ["y", 540/2]]);}
	if instance_number(obj_cam) == 0{reCam = summonObject(obj_cam);}
	if instance_number(obj_particleHandler) == 0{reParticle = summonObject(obj_particleHandler);}
	reSummoned = true;
}

function editorHandlers_delete(){
	instance_destroy(reDragger);
	instance_destroy(reMenu);
	instance_destroy(rePlayer);
	instance_destroy(rePF);
	instance_destroy(reItemHand);
	instance_destroy(reCrosshair);
	instance_destroy(reCam);
	reSummoned = false;
}
always_summon();