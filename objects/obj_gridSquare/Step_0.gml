
if (breadCrumbTimer == 5){
	distance = point_distance(x,y,playerTank.x,playerTank.y)
}
breadCrumbTimer--
if (squareNo == 295){
	print(wallSeen)
}


if (breadCrumbTimer == 1){
	if (distance < 32*5 ){
		for (var k = 0; getStepSizeRedux()*k <= 1; k++){
			var coords = findNextCoordinate(getStepSizeRedux(), k, 16, 16);
			summonObject(obj_detectionSquare, [["x", coords[0]],["y", coords[1]], ["parent", id]]);
		}
	}
}else if (breadCrumbTimer == 0){
	if (distance < 32*5){
		if (wallSeen < 1 && !instance_exists(activeBreadcrumb)){
			if squareNo == 295{
				print("YUP!");
			}
			activeBreadcrumb = summonObject(obj_breadCrumbs, [["x" , x], ["y", y]]);
		}else if (instance_exists(activeBreadcrumb) && wallSeen > 0 && activeBreadcrumb.lifeTime < 0){
			instance_destroy(activeBreadcrumb);
		}
	}else if distance >= 32*5 && instance_exists(activeBreadcrumb) && activeBreadcrumb.lifeTime < 0{
		instance_destroy(activeBreadcrumb);
	}
	wallSeen = 0;
	breadCrumbTimer = 5;
}