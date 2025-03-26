distance = point_distance(x, y, playerTank.x, playerTank.y);
distanceX = abs(playerTank.x - x);
distanceY = abs(playerTank.y - y);
for (var i = 0; getStepSize()*i <= 1; i++){
	var coords = findNextCoordinate(getStepSize(), i);
	summonObject(obj_detectionSquare, [["x", coords[0]],["y", coords[1]], ["parent", id]]);
	
}