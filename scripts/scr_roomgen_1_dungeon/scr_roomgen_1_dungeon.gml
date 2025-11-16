function initiateDungeon(floorReqList){
	
	exitDungeon = false;
	attempts = 0;
	var dungeon = {floorCount : 0, floors : ds_list_create()};
	var listSize = ds_list_size(floorReqList)
	for (var i = 0; i < listSize; i++){

		var floorReq = ds_list_find_value(floorReqList,0)

		var dfloor = populateDFloor(floorReq);
		dfloor.floorNo = dungeon.floorCount;
		var dfloor_full = generateDFloor(dfloor)
		ds_list_add(dungeon.floors,dfloor_full)
		dungeon.floorCount++;
		ds_list_delete(floorReqList,0)
	}
	
	ds_list_destroy(floorReqList);
	return dungeon
}

function regenDfloor(dfloor){
	attempts++;
	if attempts > 100{
		forceCrash("100 attempts")
	}
	exitDungeon = false;
	print("Restarting floor gen");
	//var oldDfloor = currentDungeon.floors[dfloorNo];
	var newDFloor = populateDFloor(dfloor.floorReqs);
	newDFloor.floorNo = dfloor.floorNo;
	destroydfloor(dfloor);
	return generateDFloor(newDFloor)
	
}