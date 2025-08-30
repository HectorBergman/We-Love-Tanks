function initiateDungeon(){
	exitDungeon = false;
	attempts = 0;
	dungeon = {floorCount : 0, floors : []};
	var dfloor = populateDFloor(0);
	dfloor.floorNo = dungeon.floorCount;
	dfloor.dungeon = dungeon;
	dungeon.floors[dungeon.floorCount] = dfloor;
	dungeon.floorCount++;
	dfloor = generateDFloor(dfloor)
	visualizeFloor(dfloor);
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
	var dfloor = populateDFloor(0);
	dfloor.floorNo = dfloorNo;
	dungeon.floors[dfloorNo] = dfloor;
	generateDFloor(dfloor)
	
}