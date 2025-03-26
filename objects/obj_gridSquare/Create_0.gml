depth = 99
activeBreadcrumb = noone;

breadCrumbTimer = 1;
breadCrumbTime = 5;

distance = point_distance(x, y, playerTank.x, playerTank.y);
distanceX = abs(playerTank.x - x);
distanceY = abs(playerTank.y - y);
detectionSquareWidth = 6;
wallSeen = 0;
playerSeen = false;
function getStepSizeRedux(){
	return detectionSquareWidth/distance*4
}
for (var k = 0; getStepSizeRedux()*k <= 1; k++){
	var coords = findNextCoordinate(getStepSizeRedux(), k, 16, 16);
	summonObject(obj_detectionSquare, [["x", coords[0]],["y", coords[1]], ["parent", id]]);
}
