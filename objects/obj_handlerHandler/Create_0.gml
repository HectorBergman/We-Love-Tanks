reHandler = noone;
reDragger = noone;
reMenu = noone;
rePlayer = noone;
rePF = noone;
reItemHand = noone;
reCrosshair = noone;
reCam = noone;
reSummoned = false;
reSummon = false; 


normCam = noone;
normItemHand = noone;
normCurrRoom = noone;
normPF = noone;
normCrossHair = noone;
normPlayer = noone;
normMinimapHand = noone;
normMoneyHand = noone;
normRH = noone;

normSummoned = false;
lethimcook = false;
function prepSummon(){
	normRH = summonObject(obj_roomHandler);
	lethimcook = true;
	normSummoned = true;
}
function normal_summon(){
	print("penor");
	normPF = summonObject(obj_pathFinderHandler);
	normItemHand = summonObject(obj_itemHandler);
	normPlayer = summonObject(obj_player, [["x", 960/2], ["y", 540/2]]);
	normCrossHair = summonObject(obj_crosshair, [["x", 960/2], ["y", 540/2]]);
	normCam = summonObject(obj_cam);
	normCurrRoom = summonObject(obj_currentRoomHandler);
	normMinimapHand = summonObject(obj_minimapHandler);
	normMoneyHand = summonObject(obj_moneyHandler);
	normSummoned = true;
}
function normal_delete(){
	instance_destroy(normPlayer);
	instance_destroy(normPF);
	instance_destroy(normCam);
	instance_destroy(normCrossHair);
	instance_destroy(normMinimapHand);
	instance_destroy(normCurrRoom);
	instance_destroy(normItemHand);
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