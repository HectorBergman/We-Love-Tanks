var startPoint = [1,1]
var spezRooms = [
	createSpecialRoom("item", posRequirement(coordsWithinRangeChebyshev,[startPoint, 0,3])),
	createSpecialRoom("boss", posRequirement(coordsWithinRangeChebyshev,[startPoint, 0,3]))
]
floorReqs = ds_list_create()
var oneReq = floorRequirements([3,3],startPoint,0.1,[[0,0,4,2,1], [0,0.5,4,1,1], [0,1,2,2,1], [0,1,4,1,0.5], [0,1.1,0.5,0,0]],[4,8],spezRooms)

ds_list_add(floorReqs, oneReq);ds_list_add(floorReqs, oneReq);
currentDungeon = initiateDungeon(floorReqs);
//currentCoord
//currentFloor
