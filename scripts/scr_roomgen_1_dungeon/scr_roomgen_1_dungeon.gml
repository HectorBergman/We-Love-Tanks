function initiateDungeon(floorReqList){
	exitDungeon = false;
	attempts = 0;
	var dungeon = {floorCount : 0, floors : ds_list_create()};
	var listSize = ds_list_size(floorReqList)
	for (var i = 0; i < listSize; i++){

		var floorReq = ds_list_find_value(floorReqList,0)

		var dfloor = populateDFloor(floorReq);
		dfloor.floorNo = dungeon.floorCount;
		ds_list_add(dungeon.floors,dfloor)
		dungeon.floorCount++;
		dfloor = generateDFloor(dfloor)
		ds_list_delete(floorReqList,0)
	}
	
	ds_list_destroy(floorReqList);

	return dungeon
}

function regenDfloor(dfloorNo){
	attempts++;
	if attempts > 100{
		forceCrash("100 attempts")
	}
	exitDungeon = false;
	print("Restarting floor gen");
	var oldDfloor = dungeon.floors[dfloorNo];
	destroydfloor(oldDfloor);
	var dfloor = populateDFloor(currentFloorReq);
	dfloor.floorNo = dfloorNo;
	dungeon.floors[dfloorNo] = dfloor;
	generateDFloor(dfloor)
	
}