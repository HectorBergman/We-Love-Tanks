
breadCrumbTimer--
if squareNo == 249 && breadCrumbTimer == 0{
	print(wallSeen);
}

//maybe do this once every x steps
if (breadCrumbTimer == 1){
	if (point_distance(x,y,playerTank.x,playerTank.y) < 32*5 ){
		for (var k = 0; getStepSizeRedux()*k <= 1; k++){
			var coords = findNextCoordinate(getStepSizeRedux(), k, 16, 16);
			summonObject(obj_detectionSquare, [["x", coords[0]],["y", coords[1]], ["parent", id]]);
		}
	}
}else if (breadCrumbTimer == 0){
	if (point_distance(x,y,playerTank.x,playerTank.y) < 32*5 ){
		if (wallSeen < 1 && !instance_exists(activeBreadcrumb)){
				activeBreadcrumb = summonObject(obj_breadCrumbs, [["x" , x], ["y", y]]);
		}else if (wallSeen > 0 && instance_exists(activeBreadcrumb)){
			instance_destroy(activeBreadcrumb);
		}
	}else if point_distance(x,y,playerTank.x,playerTank.y) >= 32*5 && instance_exists(activeBreadcrumb){
		instance_destroy(activeBreadcrumb);
	}
	breadCrumbTimer = 5;
}